Return-Path: <mohanreddykv@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6A8621007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Sep 2011 16:06:02 +1000 (EST)
Received: by fxe22 with SMTP id 22so3676970fxe.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Sep 2011 23:05:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316741319.2629.0.camel@pasglop>
References: <40631E9A2581F14BA60888C87A76A1FE012ED4@HYD-MKD-MBX4.wipro.com>
	<1316741319.2629.0.camel@pasglop>
Date: Fri, 23 Sep 2011 11:35:56 +0530
Message-ID: <CAEZ9+q=0xiSiG+0EsfXcVLfW5sJzmiATa04wOVagRJfaj_6HXg@mail.gmail.com>
Subject: Re: I2c driver crash
From: MohanReddy koppula <mohanreddykv@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
	smitha.vanga@wipro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I think the client->adapter pointer is NULL. Make sure the
ds75_attach_adapte() is called before you invoke ioctl().

-Mohan

On Fri, Sep 23, 2011 at 6:58 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2011-09-22 at 15:25 +0000, smitha.vanga@wipro.com wrote:
>> Hi Scott,
>>
>> When I call if =A0i2c_master_send(&ds75->i2c_client,buffer,2) it
>> crashes. In module initialization I don't see any errors. Below are
>> kernel messages. Could you please let me know what may be the reason
>> for this crash.
>
> Why the heck are you trying to write a new driver for ds75 ? There's
> already one in there (lm75, same thing).
>
> Cheers,
> Ben.
>
>> -----------Logs---------
>> Loading Temperature Sensor Interface module (temp_if.ko)
>> ds75_init
>> DS75_DRIVER : Open
>> DS75_DRIVER : Device Open Successful!
>> DS75_DRIVER =A0: ioctl TEMP_READ cmd 1
>> =A0ds75_temp_read calling i2c_master_send
>> In i2c_master_send enter-------
>> Unable to handle kernel paging request for data at address 0x00000010
>> Faulting instruction address: 0xc01b06a4
>> Oops: Kernel access of bad area, sig: 11 [#1]
>>
>> Modules linked in: temp_if gpio_if
>> NIP: C01B06A4 LR: C01B06A0 CTR: C019BC90
>> REGS: c309bdc0 TRAP: 0300 =A0 Not tainted
>> (2.6.21.7-hrt1-cfs-v22-grsec-WR2.0bl_cgl)
>> MSR: 00009032 <EE,ME,IR,DR> =A0CR: 44004822 =A0XER: 00000000
>> DAR: 00000010, DSISR: 20000000
>> TASK =3D c306f810[145] 'epn412' THREAD: c309a000
>> GPR00: 00007D00 C309BE70 C306F810 C02A0000 00000001 00000001 00000000
>> FDFBD0A0
>> GPR08: 003DE8A0 A827A936 00003F78 C02EAE88 00000001 1011C7C0 03EFD000
>> FFFFFFFF
>> GPR16: 00000001 00000000 007FFC00 37942FA8 1012EAC0 1001E530 37942FB4
>> 00000003
>> GPR24: 37942FB4 00000000 003D0F00 C309BEA8 FFFFFFF7 00000008 C309BEA8
>> 00000002
>> Call Trace:
>> [C309BE70] [C01B0698] =A0(unreliable)
>> [C309BEA0] [C50B71DC]
>> [C309BED0] [C007A0D0]
>> [C309BEE0] [C007A158]
>> [C309BF10] [C007A4EC]
>> [C309BF40] [C000E780]
>> --- Exception: c01Instruction dump:
>> 7c0802a6 bf61001c 7c7d1b78 3c60c02a 386313b4 7cbf2b78 90010034
>> 7c9b2378
>> 4be6bc79 386007d0 4be5ac6d 3c60c02a <839d0008> 386313d8 4be6bc61
>> a01d0004
>>
>>
>>
>>
>> Below is the driver code.
>> -------------------------
>>
>> #include "temp_if.h"
>> #include <asm-powerpc/uaccess.h>
>> #include <linux/i2c.h>
>> //#include <asm/arch/platform.h>
>>
>>
>> #define I2C_DEBUG
>>
>> #ifdef =A0 =A0 =A0I2C_DEBUG
>> #define =A0 =A0 I2C_DBG1(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_=
WARNING x)
>> #define =A0 =A0 I2C_DBG2(x,y) =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WA=
RNING x,y)
>> #define =A0 =A0 I2C_DBG3(x,y,z) =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARN=
ING x,y,z)
>> #define =A0 =A0 I2C_DBG4(w,x,y,z) =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNIN=
G w,x,y,z)
>> #else
>> #define I2C_DBG1(x)
>> #define I2C_DBG2(x,y)
>> #define I2C_DBG3(x,y,z)
>> #define I2C_DBG4(w,x,y,z)
>> #endif
>>
>> /* Function Prototype */
>> static int ds75_open(struct inode *inode, struct file *filp);
>> static int ds75_iotcl(struct inode *inode, struct file *flip, unsigned
>> int cmd, unsigned long arg);
>> static int ds75_release(struct inode *inode, struct file *flip);
>> int ds75_attach_client(struct ds75_data * ds75, struct i2c_adapter
>> *adapter);
>>
>> int ds75_attach_adapter(struct i2c_adapter *adapter);
>> int ds75_detach_client(struct i2c_client *client);
>>
>>
>>
>>
>> /* Structure */
>> static struct file_operations tmpsensor_fops =3D
>> {
>> =A0 =A0 =A0 =A0 ioctl: =A0 =A0 =A0 =A0 =A0ds75_iotcl,
>> =A0 =A0 =A0 =A0 open: =A0 =A0 =A0 =A0 =A0 ds75_open,
>> =A0 =A0 =A0 =A0 release: =A0 =A0 =A0 =A0ds75_release,
>>
>> };
>>
>> static struct i2c_driver ds75_driver =3D {
>> =A0 =A0 =A0 =A0 .driver =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "DS75",
>> =A0 =A0 =A0 =A0 },
>> =A0 =A0 =A0 =A0 .attach_adapter =3D ds75_attach_adapter,
>> =A0 =A0 =A0 =A0 .detach_client =A0=3D ds75_detach_client,
>> };
>>
>> /* Global Variable */
>> static int s_nI2CMajor =3D 0;
>> static int s_bI2CDevOpen =3D 0;
>> static int s_nUseCnt =3D 0;
>> struct ds75_data *ds75;
>>
>>
>> static int ds75_open(struct inode *inode, struct file *flip)
>> {
>> =A0 I2C_DBG1( "DS75_DRIVER : Open\n");
>> =A0 if(s_bI2CDevOpen =3D=3D 0)
>> =A0 =A0 {
>> =A0 =A0 =A0 I2C_DBG1("DS75_DRIVER : Device Open Successful!\n");
>> =A0 =A0 =A0 s_bI2CDevOpen =3D 1;
>> =A0 =A0 =A0 s_nUseCnt++;
>>
>> =A0 =A0 }
>> =A0 else
>> =A0 =A0 {
>> =A0 =A0 =A0 I2C_DBG1("DS75_DRIVER : Device Already Opened Successfully!\=
n");
>> =A0 =A0 =A0 s_bI2CDevOpen =3D 1;
>> =A0 =A0 =A0 s_nUseCnt++;
>> =A0 =A0 }
>> =A0 return 0;
>> }
>>
>>
>> static int ds75_release(struct inode *inode, struct file *flip)
>> {
>> =A0 I2C_DBG1 (KERN_INFO "Entering ds75_release\n" );
>> =A0 if(s_bI2CDevOpen)
>> =A0 =A0 {
>> =A0 =A0 =A0 if( s_nUseCnt <=3D 0 )
>> =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 I2C_DBG1("DS75_DRIVER =A0: i2c driver can't be relea=
sed!\n");
>> =A0 =A0 =A0 =A0 =A0 return -EIO;
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 I2C_DBG1("DS75_DRIVER =A0: Release Successful!\n");
>> =A0 =A0 =A0 =A0 =A0 s_nUseCnt--;
>> =A0 =A0 =A0 =A0 =A0 if( s_nUseCnt =3D=3D 0 )
>> =A0 =A0 =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 s_bI2CDevOpen =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_DBG1("DS75_DRIVER =A0: I2C Driver is Clo=
sed!\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 return 0;
>> =A0 =A0 }
>> =A0 else
>> =A0 =A0 {
>> =A0 =A0 =A0 I2C_DBG1("DS75_DRIVER =A0: Release Fail! (Device is Not Open=
)\n");
>> =A0 =A0 =A0 return -EIO;
>> =A0 =A0 }
>> }
>>
>> /*
>> =A0This function will read the Temperature from the device and copies to
>> user space
>> */
>> static int ds75_temp_read(struct ds75_msg_t *pData)
>> {
>> =A0 =A0 =A0//unsigned char buffer[4];
>> =A0 =A0 =A0signed char buffer[4];
>> =A0 =A0 =A0int ret;
>> =A0 =A0 =A0buffer[0]=3D0; =A0/* Writing 0 in to Pointer register. --> Te=
mprature
>> read register */
>> =A0 =A0 =A0if ((ret =3D i2c_master_send(&ds75->i2c_client,buffer,2)) !=
=3D2)
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0I2C_DBG2("DS75_DRIVER =A0: Error writing to I2C ret =
=3D %d
>> \n",ret);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>> =A0 =A0 =A0}
>>
>> =A0 =A0 =A0/* reading from the temperature read register */
>> =A0 =A0 =A0if (i2c_master_recv(&ds75->i2c_client,buffer,2)!=3D 2)
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0I2C_DBG1("DS75_DRIVER =A0: Error reading from I2C\n")=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>> =A0 =A0 =A0}
>>
>> =A0 =A0 =A0//I2C_DBG3("DS75_DRIVER: data[0] =3D %d, data[1] =3D %d
>> \n",buffer[0],buffer[1]);
>> =A0 =A0 =A0 =A0 //I2C_DBG3("DS75_DRIVER: data[0] =3D %d, data[1] =3D %d
>> \n",buffer[0],buffer[1]);
>>
>> =A0 =A0 =A0/* Copy User Memory Area */
>> =A0 =A0 =A0 =A0 =A0 =A0if(copy_to_user(pData->ReadData,buffer, 2 ) !=3D =
0)
>> =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_DBG1("DS75_DRIVER =A0: error in copying =
to user
>> space");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0return 0; =A0/* Success */
>>
>> }
>>
>>
>> static int ds75_iotcl(struct inode *inode, struct file *flip, unsigned
>> int cmd, unsigned long arg)
>> {
>> =A0 =A0 =A0 =A0 int nRetVal =3D 0;
>>
>> =A0 =A0 =A0 =A0 if( ((struct ds75_msg_t *)arg) =3D=3D NULL ){
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_DBG1("DS75_DRIVER =A0: ioctl Message=
 Buff must not
>> be NULL\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 switch(cmd){
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case TEMP_READ:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_DBG2("DS75_DRIVER =
=A0: ioctl TEMP_READ cmd %
>> d\n",cmd);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nRetVal =3D ds75_temp_re=
ad((struct ds75_msg_t *)
>> arg);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Error! */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_DBG1("DS75_DRIVER =
=A0: Command =A0not
>> implemented\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nRetVal =3D -EIO;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 return nRetVal;
>> }
>>
>>
>> /*
>> =A0* =A0i2c_attach_client - tries to detect and initialize slics
>> */
>> int ds75_attach_client(struct ds75_data * ds75, struct i2c_adapter
>> *adapter)
>> {
>> =A0 =A0 =A0 =A0 struct i2c_client * client;
>>
>> =A0 =A0 =A0 =A0 /* register i2c client */
>> =A0 =A0 =A0 =A0 client =3D &ds75->i2c_client;
>> =A0 =A0 =A0 =A0 client->adapter =3D adapter;
>> =A0 =A0 =A0 =A0 client->driver =3D &ds75_driver;
>> // =A0 =A0 =A0client->flags =3D I2C_CLIENT_ALLOW_USE;
>> =A0 client->addr =3D DS75_ADDR;
>> =A0 strlcpy(client->name, "DS75", I2C_NAME_SIZE);
>> =A0 =A0 =A0 =A0 i2c_set_clientdata(client, ds75);
>>
>> =A0 =A0 =A0 =A0 if (i2c_attach_client(client))
>> =A0 =A0 =A0return -1;
>>
>> =A0 =A0 =A0 =A0 printk (KERN_INFO DS75_DRIVER_NAME ": I2C client attache=
d\n");
>> =A0 =A0 =A0 =A0 return 0;
>> }
>>
>> /*
>> =A0* =A0i2c_attach_adapter - initializes the maxim driver
>> */
>> int ds75_attach_adapter(struct i2c_adapter *adapter)
>> {
>> =A0 =A0 =A0 =A0 /* allocate maxim_data structure */
>> =A0 =A0 =A0 =A0 ds75 =3D kmalloc(sizeof (struct ds75_data), GFP_KERNEL);
>> =A0 =A0 =A0 =A0 if (ds75 =3D=3D NULL)
>> =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0printk (KERN_ERR "Unable to allocate memory for d=
s75 temp
>> sensor driver\n");
>> =A0 =A0 =A0 =A0 =A0 =A0goto err0;
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 memset(ds75, 0, sizeof(struct ds75_data));
>>
>> =A0 =A0 =A0 =A0 /* Attach Spi Client */
>> =A0 =A0 =A0 =A0 if (ds75_attach_client(ds75, adapter) !=3D 0)
>> =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0printk (KERN_ERR "No ds75 device detected\n");
>> =A0 =A0 =A0 =A0 =A0 =A0goto err1;
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 return 0;
>>
>> err1:
>> =A0 =A0 =A0 =A0 kfree(ds75);
>> err0:
>> =A0 =A0 =A0 =A0 return -1;
>> }
>>
>> /*
>> =A0* =A0i2c_detach_client - cleans up the maxim driver
>> */
>> int ds75_detach_client(struct i2c_client *client)
>> {
>> =A0 =A0 =A0 =A0 struct ds75_data *ds75 =3D i2c_get_clientdata(client);
>>
>> =A0 =A0 =A0 =A0 if (ds75->owned_irq)
>> =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(ds75->irq, ds75);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds75->owned_irq =3D 0;
>>
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 i2c_detach_client(&ds75->i2c_client);
>>
>> =A0 =A0 =A0 =A0 kfree (ds75); =A0 =A0 =A0// Free the kernel memory */
>>
>> =A0 =A0 =A0 =A0 return 0;
>> }
>>
>>
>>
>>
>> /*
>> =A0* Temperature sensor DS75 init -
>> =A0*
>> =A0*/
>> int __init ds75_init(void)
>> {
>> =A0 =A0 =A0 =A0 int rc;
>> =A0 =A0 =A0 =A0 rc =3D i2c_add_driver(&ds75_driver);
>> =A0 =A0 =A0 =A0 if (rc)
>> =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk (KERN_ERR DS75_DRIVER_NAME ": una=
ble to add
>> driver\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 rc =3D register_chrdev (DS75_DEVICE_MAJOR_NUM, DS75_DRIV=
ER_NAME,
>> &tmpsensor_fops);
>> =A0 =A0 =A0 =A0 if (rc)
>> =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk (KERN_ERR DS75_DRIVER_NAME ": una=
ble to
>> register char device\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 return 0;
>> }
>>
>> /**
>> =A0* maxim _exit -
>> =A0*
>> =A0*
>> =A0*/
>> void __exit ds75_exit(void)
>> {
>> =A0 =A0 =A0 =A0 unregister_chrdev (DS75_DEVICE_MAJOR_NUM, DS75_DRIVER_NA=
ME);
>>
>> =A0 =A0 =A0 =A0 i2c_del_driver(&ds75_driver);
>> }
>>
>> MODULE_AUTHOR("xxxx");
>> MODULE_DESCRIPTION("DS75 I2C driver");
>> MODULE_LICENSE("GPL");
>>
>> module_init(ds75_init);
>> module_exit(ds75_exit);
>>
>>
>> Regards,
>> Smitha
>>
>> Please do not print this email unless it is absolutely necessary.
>>
>> The information contained in this electronic message and any
>> attachments to this message are intended for the exclusive use of the
>> addressee(s) and may contain proprietary, confidential or privileged
>> information. If you are not the intended recipient, you should not
>> disseminate, distribute or copy this e-mail. Please notify the sender
>> immediately and destroy all copies of this message and any
>> attachments.
>>
>> WARNING: Computer viruses can be transmitted via email. The recipient
>> should check this email and any attachments for the presence of
>> viruses. The company accepts no liability for any damage caused by any
>> virus transmitted by this email.
>>
>> www.wipro.com
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
