Return-Path: <eha@doredevelopment.dk>
Received: from zmta01.irigo.dk (zmta01.cabocomm.dk [193.200.44.52])
	by ozlabs.org (Postfix) with ESMTP id E3724DE00B
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 18:48:31 +1000 (EST)
Message-ID: <4A0BDAD6.5020005@doredevelopment.dk>
Date: Thu, 14 May 2009 10:48:22 +0200
From: Esben Haabendal <eha@doredevelopment.dk>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
References: <4A0BD1DB.4090305@doredevelopment.dk>
	<20090514083453.GB3043@pengutronix.de>
In-Reply-To: <20090514083453.GB3043@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfram Sang wrote:
> On Thu, May 14, 2009 at 10:10:03AM +0200, Esben Haabendal wrote:
>   
>> This fixes MAL (arbitration lost) bug caused by illegal use of
>> RSTA (repeated START) after STOP condition generated after last byte
>> of reads.
>>
>>     
>
> Could you elaborate a bit, please? Like an example when the original bug
> occured (so I could reproduce easily) and how this patch actually solves
> the problem.
>   
Sure. I used the following code to initialize a CS4265 chip:
(simplified here for the example)

static int
i2c_init_chip(void)
{
    int err=0;
    char write_dac_control_1[] = { 0x03, chip->regs.dac_control_1 };
    char seek_chip_id[] = { 0x01 };
    char write_power_control[] = { 0x02, chip->regs.power_control };
    struct i2c_msg cs4265_init_cmds[] = {
        { chip->i2c_addr, 0, 2, write_dac_control_1 },
        { chip->i2c_addr, 0, 1, seek_chip_id },
        { chip->i2c_addr, I2C_M_RD, 1, &regs.chip_id },
        { chip->i2c_addr, 0, 2, write_power_control },
    };

    err = i2c_transfer(i2c, cs4265_init_cmds,
               sizeof(cs4265_init_cmds)/sizeof(*cs4265_init_cmds));
    if (err < 0) {
        printk(KERN_ERR "i2c_transfer failed: %d\n", err);
        return err;
    }

    return 0;
}

I have added some additional debug output and traces something like this:

[   36.114297] writeccr 80 [MEN]
[   36.114324] mpc_xfer: 2 bytes to 4f:W - 1 of 5 messages
[   36.120176] next 1 bytes to 4f:W
[   36.124159] mpc_write addr=4f len=2
[   36.128044] writeccr 80 [MEN]
[   36.128062] writeccr f0 [MEN MIEN MSTA MTX] -> START
[   36.128219] I2C: SR=a2
[   36.131528] I2C: SR=a6
[   36.134406] I2C: SR=a2

[   36.137165] mpc_xfer: 1 bytes to 4f:W - 2 of 5 messages
[   36.142802] next 1 bytes to 4f:R
[   36.146699] mpc_write addr=4f len=1
[   36.150583] writeccr f4 [MEN MIEN MSTA MTX RSTA] -> repeated START
[   36.150758] I2C: SR=a2
[   36.153851] I2C: SR=a6

[   36.156236] mpc_xfer: 1 bytes to 4f:R - 3 of 5 messages
[   36.162081] next 2 bytes to 4f:W
[   36.166062] mpc_read addr=4f len=1
[   36.169858] writeccr f4 [MEN MIEN MSTA MTX RSTA] -> repeated START
[   36.170031] I2C: SR=a6
[   36.172993] writeccr e8 [MEN MIEN MSTA TXAK] -> receive & no ACK
[   36.173143] I2C: SR=a7
[   36.175511] writeccr c8 [MEN MIEN TXAK] -> STOP

[   36.175529] mpc_xfer: 2 bytes to 4f:W - 4 of 5 messages
[   36.181804] next 2 bytes to 4f:W
[   36.185788] mpc_write addr=4f len=2
[   36.189672] writeccr f4 [MEN MIEN MSTA MTX RSTA] -> repeated START
[   36.189704] I2C: SR=b7
[   36.192072] I2C: MAL
[   36.195075] i2c_wait(address) error: -5
[   36.199311] writeccr 80

The problem is that after the STOP condition, the following i2c_msg will be
attempted with a repeated START, which according to specification will
cause a MAL, which also happens.  My MPC8360ERM reads:

"Attempting a repeated START at the wrong time (or if the bus is owned
by another master), results in loss of arbitration."

Which I know read as it that we must own the I2C bus when using RSTA.


>
>   
>> Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
>> ---
>>  drivers/i2c/busses/i2c-mpc.c |    9 +++++++--
>>  1 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
>> index 4af5c09..9fe05d9 100644
>> --- a/drivers/i2c/busses/i2c-mpc.c
>> +++ b/drivers/i2c/busses/i2c-mpc.c
>> @@ -456,17 +456,22 @@ static int mpc_xfer(struct i2c_adapter *adap,  
>> struct i2c_msg *msgs, int num)
>>  	}
>>
>>  	for (i = 0; ret >= 0 && i < num; i++) {
>> +		int restart = i;
>>  		pmsg = &msgs[i];
>>  		dev_dbg(i2c->dev,
>>  			"Doing %s %d bytes to 0x%02x - %d of %d messages\n",
>>  			pmsg->flags & I2C_M_RD ? "read" : "write",
>>  			pmsg->len, pmsg->addr, i + 1, num);
>> +		if (i > 0 && ((pmsg-1)->flags & I2C_M_RD))
>>     
>
> CodingStyle: Spaces around '-'
>   

Ok.
>   
>> +			restart = 0;
>>  		if (pmsg->flags & I2C_M_RD)
>>  			ret =
>> -			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
>> +			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len,
>> +				     restart);
>>  		else
>>  			ret =
>> -			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
>> +			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len,
>> +				      restart);
>>  	}
>>  	mpc_i2c_stop(i2c);
>>  	return (ret < 0) ? ret : num;
>> -- 
>> 1.6.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>     
>
>   
