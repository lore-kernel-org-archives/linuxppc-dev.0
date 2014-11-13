Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FE751A001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 21:56:23 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44EB0140082
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 21:56:20 +1100 (AEDT)
Message-ID: <1415876169.666.2.camel@kernel.crashing.org>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 13 Nov 2014 21:56:09 +1100
In-Reply-To: <20141113075817.GA1288@katana>
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
 <20141113075817.GA1288@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-13 at 08:58 +0100, Wolfram Sang wrote:

> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/i2c.h>
> > +#include <linux/device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of.h>
> > +#include <linux/mm.h>
> > +#include <asm/opal.h>
> > +#include <asm/firmware.h>
> 
> Please sort the includes.

Ugh ? Since when do we do that ? :-)

> > +static int i2c_opal_send_request(u32 bus_id, struct opal_i2c_request *req)
> > +{
> > +	struct opal_msg msg;
> > +	int token, rc;
> > +
> > +	token = opal_async_get_token_interruptible();
> > +	if (token < 0) {
> > +		if (token != -ERESTARTSYS)
> > +			pr_err("Failed to get the async token\n");
> > +
> > +		return token;
> > +	}
> > +
> > +	rc = opal_i2c_request(token, bus_id, req);
> > +	if (rc != OPAL_ASYNC_COMPLETION) {
> > +		rc = -EIO;
> > +		goto exit;
> > +	}
> > +
> > +	rc = opal_async_wait_response(token, &msg);
> > +	if (rc) {
> > +		rc = -EIO;
> > +		goto exit;
> 
> Is it really -EIO? Maybe -ETIMEDOUT?

No, there is no timeout, if that fails something went quite wrong, it
could almost be a BUG_ON (basically we passed a wrong token or a NULL
msg).

> > +	}
> > +
> > +	rc = be64_to_cpu(msg.params[1]);
> > +	if (rc != OPAL_SUCCESS) {
> > +		rc = -EIO;
> > +		goto exit;
> > +	}
> > +
> > +exit:
> > +	opal_async_release_token(token);
> > +	return rc;
> > +}
> > +
> > +static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> > +				int num)
> > +{
> > +	unsigned long opal_id = (unsigned long)adap->algo_data;
> > +	struct opal_i2c_request req;
> > +	int rc, i;
> > +
> > +	/* We only support fairly simple combinations here of one
> > +	 * or two messages
> > +	 */
> 
> I don't think you should offer I2C_FUNC_I2C with those limitations. Is
> there a case you really needs this?

Yes there is, and it's pretty common :-) I actually added this to
Neelesh original driver, it's the "smbus" style but with 2 bytes offset.
Typically what we need for driver such as at24. They use normal raw i2c
writes for writes but need the 2-bytes write + read combo without stop
for reads.

> > +	memset(&req, 0, sizeof(req));
> > +	switch (num) {
> > +	case 0:
> > +		return 0;
> > +	case 1:
> > +		req.type = (msgs[0].flags & I2C_M_RD) ?
> > +			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
> > +		req.addr = cpu_to_be16(msgs[0].addr);
> > +		req.size = cpu_to_be32(msgs[0].len);
> > +		req.buffer_ra = cpu_to_be64(__pa(msgs[0].buf));
> > +		break;
> > +	case 2:
> > +		/* For two messages, we basically support only simple
> > +		 * smbus transactions of a write plus a read. We might
> > +		 * want to allow also two writes but we'd have to bounce
> > +		 * the data into a single buffer.
> > +		 */
> > +		if ((msgs[0].flags & I2C_M_RD) || !(msgs[1].flags & I2C_M_RD))
> > +			return -EIO;
> > +		if (msgs[0].len > 4)
> > +			return -EIO;
> > +		if (msgs[0].addr != msgs[1].addr)
> > +			return -EIO;
> 
> -EOPNOTSUPP? Please check Documentation/i2c/fault-codes for the error
> codes we use.

Ok.

> > +		req.type = OPAL_I2C_SM_READ;
> > +		req.addr = cpu_to_be16(msgs[0].addr);
> > +		req.subaddr_sz = msgs[0].len;
> > +		for (i = 0; i < msgs[0].len; i++)
> > +			req.subaddr = (req.subaddr << 8) | msgs[0].buf[i];
> > +		req.subaddr = cpu_to_be32(req.subaddr);
> > +		req.size = cpu_to_be32(msgs[1].len);
> > +		req.buffer_ra = cpu_to_be64(__pa(msgs[1].buf));
> > +		break;
> > +	default:
> > +		return -EIO;
> > +	}
> > +
> > +	rc = i2c_opal_send_request(opal_id, &req);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return num;
> > +}
> > +
> > +static int i2c_opal_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> > +			       unsigned short flags, char read_write,
> > +			       u8 command, int size, union i2c_smbus_data *data)
> > +{
> > +	unsigned long opal_id = (unsigned long)adap->algo_data;
> > +	struct opal_i2c_request req;
> > +	u8 local[2];
> > +	int rc;
> > +
> > +	memset(&req, 0, sizeof(req));
> > +
> > +	req.addr = cpu_to_be16(addr);
> > +	switch (size) {
> > +	case I2C_SMBUS_BYTE:
> > +		req.buffer_ra = cpu_to_be64(__pa(&data->byte));
> > +		req.size = cpu_to_be32(1);
> > +		/* Fall through */
> > +	case I2C_SMBUS_QUICK:
> > +		req.type = (read_write == I2C_SMBUS_READ) ?
> > +			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
> > +		break;
> > +	case I2C_SMBUS_BYTE_DATA:
> > +		req.buffer_ra = cpu_to_be64(__pa(&data->byte));
> > +		req.size = cpu_to_be32(1);
> > +		req.subaddr = cpu_to_be32(command);
> > +		req.subaddr_sz = 1;
> > +		req.type = (read_write == I2C_SMBUS_READ) ?
> > +			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
> > +		break;
> > +	case I2C_SMBUS_WORD_DATA:
> > +		if (!read_write) {
> > +			local[0] = data->word & 0xff;
> > +			local[1] = (data->word >> 8) & 0xff;
> > +		}
> > +		req.buffer_ra = cpu_to_be64(__pa(local));
> > +		req.size = cpu_to_be32(2);
> > +		req.subaddr = cpu_to_be32(command);
> > +		req.subaddr_sz = 1;
> > +		req.type = (read_write == I2C_SMBUS_READ) ?
> > +			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
> > +		break;
> > +	case I2C_SMBUS_I2C_BLOCK_DATA:
> > +		req.buffer_ra = cpu_to_be64(__pa(&data->block[1]));
> > +		req.size = cpu_to_be32(data->block[0]);
> > +		req.subaddr = cpu_to_be32(command);
> > +		req.subaddr_sz = 1;
> > +		req.type = (read_write == I2C_SMBUS_READ) ?
> > +			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	rc = i2c_opal_send_request(opal_id, &req);
> > +	if (!rc && read_write && size == I2C_SMBUS_WORD_DATA) {
> > +		data->word = ((u16)local[1]) << 8;
> > +		data->word |= local[0];
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> > +static u32 i2c_opal_func(struct i2c_adapter *adapter)
> > +{
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> > +	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> > +	       I2C_FUNC_SMBUS_I2C_BLOCK;
> > +}
> 
> See comment above about I2C_FUNC_I2C?

We really do need it.

> > +static const struct i2c_algorithm i2c_opal_algo = {
> > +	.master_xfer	= i2c_opal_master_xfer,
> > +	.smbus_xfer	= i2c_opal_smbus_xfer,
> > +	.functionality	= i2c_opal_func,
> > +};
> > +
> > +static int i2c_opal_probe(struct platform_device *pdev)
> > +{
> > +	struct i2c_adapter	*adapter;
> > +	const char		*pname;
> > +	u32			opal_id;
> > +	int			rc;
> > +
> > +	if (!pdev->dev.of_node)
> > +		return -ENODEV;
> 
> Can this happen? How would the match happen otherwise?

I wasn't sure we didn't have a way to force matches by hand using sysfs
like we do on pci, so better safe than sorry.

> > +	rc = of_property_read_u32(pdev->dev.of_node, "ibm,opal-id", &opal_id);
> > +	if (rc) {
> > +		dev_err(&pdev->dev, "Missing ibm,opal-id property !\n");
> > +		return -EIO;
> > +	}
> > +	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> 
> devm_kzalloc?

Ah, I never got the knack of using the new devm stuff, Neelesh, can you
take care of this ?

> > +	if (!adapter)
> > +		return -ENOMEM;
> > +	adapter->algo = &i2c_opal_algo;
> > +	adapter->algo_data = (void *)(unsigned long)opal_id;
> 
> double cast?

Yes, on purpose. opal_id is u32 which is an unsigned int. You need to
cast it to an unsigned long before you cast it to a pointer or you get a
warning.

> > +	adapter->dev.parent = &pdev->dev;
> > +	adapter->dev.of_node = of_node_get(pdev->dev.of_node);
> > +	pname = of_get_property(pdev->dev.of_node, "port-name", NULL);
> 
> I have never seen this binding before, it looks fishy. Where is it documented?

We made it up, like pretty every SoC vendor out there. What's fishy
about it ? It's a very good way to get fixed i2c port names on the
system, the firmware defines them.

> > +	if (pname)
> > +		strlcpy(adapter->name, pname, sizeof(adapter->name));
> > +	else
> > +		strlcpy(adapter->name, "opal", sizeof(adapter->name));
> > +
> > +	platform_set_drvdata(pdev, adapter);
> > +	rc = i2c_add_adapter(adapter);
> > +	if (rc)
> > +		dev_err(&pdev->dev, "Failed to register the i2c adapter\n");
> 
> Leaking 'adapter' here.
> 
> > +
> > +	return rc;
> > +}
> > +
> > +static int i2c_opal_remove(struct platform_device *pdev)
> > +{
> > +	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
> > +
> > +	i2c_del_adapter(adapter);
> > +
> > +	kfree(adapter);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id i2c_opal_of_match[] = {
> > +	{
> > +		.compatible = "ibm,power8-i2c-port",
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, i2c_opal_of_match);
> > +
> > +static struct platform_driver i2c_opal_driver = {
> > +	.probe	= i2c_opal_probe,
> > +	.remove	= i2c_opal_remove,
> > +	.driver	= {
> > +		.name		= "i2c-opal",
> > +		.owner		= THIS_MODULE,
> 
> Not needed.
> 
> > +		.of_match_table	= i2c_opal_of_match,
> > +	},
> > +};
> > +
> > +static int __init i2c_opal_init(void)
> > +{
> > +	if (!firmware_has_feature(FW_FEATURE_OPAL))
> > +		return -ENODEV;
> > +
> > +	return platform_driver_register(&i2c_opal_driver);
> > +}
> > +
> > +static void __exit i2c_opal_exit(void)
> > +{
> > +	return platform_driver_unregister(&i2c_opal_driver);
> > +}
> > +
> > +MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
> > +MODULE_DESCRIPTION("IBM OPAL I2C driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +module_init(i2c_opal_init);
> > +module_exit(i2c_opal_exit);
> 
> Please put thos right below the functions it references.
> 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
