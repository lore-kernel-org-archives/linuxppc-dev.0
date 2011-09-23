Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CD76B6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Sep 2011 11:28:52 +1000 (EST)
Subject: Re: I2c driver crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: smitha.vanga@wipro.com
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE012ED4@HYD-MKD-MBX4.wipro.com>
References: <40631E9A2581F14BA60888C87A76A1FE012ED4@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Sep 2011 11:28:39 +1000
Message-ID: <1316741319.2629.0.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-09-22 at 15:25 +0000, smitha.vanga@wipro.com wrote:
> Hi Scott,
> 
> When I call if  i2c_master_send(&ds75->i2c_client,buffer,2) it
> crashes. In module initialization I don't see any errors. Below are
> kernel messages. Could you please let me know what may be the reason
> for this crash.

Why the heck are you trying to write a new driver for ds75 ? There's
already one in there (lm75, same thing).

Cheers,
Ben.

> -----------Logs---------
> Loading Temperature Sensor Interface module (temp_if.ko)
> ds75_init
> DS75_DRIVER : Open
> DS75_DRIVER : Device Open Successful!
> DS75_DRIVER  : ioctl TEMP_READ cmd 1
>  ds75_temp_read calling i2c_master_send
> In i2c_master_send enter-------
> Unable to handle kernel paging request for data at address 0x00000010
> Faulting instruction address: 0xc01b06a4
> Oops: Kernel access of bad area, sig: 11 [#1]
> 
> Modules linked in: temp_if gpio_if
> NIP: C01B06A4 LR: C01B06A0 CTR: C019BC90
> REGS: c309bdc0 TRAP: 0300   Not tainted
> (2.6.21.7-hrt1-cfs-v22-grsec-WR2.0bl_cgl)
> MSR: 00009032 <EE,ME,IR,DR>  CR: 44004822  XER: 00000000
> DAR: 00000010, DSISR: 20000000
> TASK = c306f810[145] 'epn412' THREAD: c309a000
> GPR00: 00007D00 C309BE70 C306F810 C02A0000 00000001 00000001 00000000
> FDFBD0A0
> GPR08: 003DE8A0 A827A936 00003F78 C02EAE88 00000001 1011C7C0 03EFD000
> FFFFFFFF
> GPR16: 00000001 00000000 007FFC00 37942FA8 1012EAC0 1001E530 37942FB4
> 00000003
> GPR24: 37942FB4 00000000 003D0F00 C309BEA8 FFFFFFF7 00000008 C309BEA8
> 00000002
> Call Trace:
> [C309BE70] [C01B0698]  (unreliable)
> [C309BEA0] [C50B71DC]
> [C309BED0] [C007A0D0]
> [C309BEE0] [C007A158]
> [C309BF10] [C007A4EC]
> [C309BF40] [C000E780]
> --- Exception: c01Instruction dump:
> 7c0802a6 bf61001c 7c7d1b78 3c60c02a 386313b4 7cbf2b78 90010034
> 7c9b2378
> 4be6bc79 386007d0 4be5ac6d 3c60c02a <839d0008> 386313d8 4be6bc61
> a01d0004
> 
> 
> 
> 
> Below is the driver code.
> -------------------------
> 
> #include "temp_if.h"
> #include <asm-powerpc/uaccess.h>
> #include <linux/i2c.h>
> //#include <asm/arch/platform.h>
> 
> 
> #define I2C_DEBUG
> 
> #ifdef      I2C_DEBUG
> #define     I2C_DBG1(x)                 printk(KERN_WARNING x)
> #define     I2C_DBG2(x,y)               printk(KERN_WARNING x,y)
> #define     I2C_DBG3(x,y,z)             printk(KERN_WARNING x,y,z)
> #define     I2C_DBG4(w,x,y,z)           printk(KERN_WARNING w,x,y,z)
> #else
> #define I2C_DBG1(x)                
> #define I2C_DBG2(x,y)
> #define I2C_DBG3(x,y,z)
> #define I2C_DBG4(w,x,y,z)
> #endif
> 
> /* Function Prototype */
> static int ds75_open(struct inode *inode, struct file *filp);
> static int ds75_iotcl(struct inode *inode, struct file *flip, unsigned
> int cmd, unsigned long arg);
> static int ds75_release(struct inode *inode, struct file *flip);
> int ds75_attach_client(struct ds75_data * ds75, struct i2c_adapter
> *adapter);
> 
> int ds75_attach_adapter(struct i2c_adapter *adapter);
> int ds75_detach_client(struct i2c_client *client);
> 
> 
> 
> 
> /* Structure */
> static struct file_operations tmpsensor_fops =
> {
>         ioctl:          ds75_iotcl,
>         open:           ds75_open,
>         release:        ds75_release,  
> 
> };
> 
> static struct i2c_driver ds75_driver = {
>         .driver = {
>                 .name   = "DS75",
>         },
>         .attach_adapter = ds75_attach_adapter,
>         .detach_client  = ds75_detach_client,
> };
> 
> /* Global Variable */
> static int s_nI2CMajor = 0;
> static int s_bI2CDevOpen = 0;
> static int s_nUseCnt = 0;
> struct ds75_data *ds75;
> 
> 
> static int ds75_open(struct inode *inode, struct file *flip)
> {
>   I2C_DBG1( "DS75_DRIVER : Open\n");
>   if(s_bI2CDevOpen == 0)
>     {
>       I2C_DBG1("DS75_DRIVER : Device Open Successful!\n");
>       s_bI2CDevOpen = 1;
>       s_nUseCnt++;
>      
>     }
>   else
>     {
>       I2C_DBG1("DS75_DRIVER : Device Already Opened Successfully!\n");
>       s_bI2CDevOpen = 1;
>       s_nUseCnt++;
>     }
>   return 0;
> }
> 
> 
> static int ds75_release(struct inode *inode, struct file *flip)
> {
>   I2C_DBG1 (KERN_INFO "Entering ds75_release\n" );
>   if(s_bI2CDevOpen)
>     {
>       if( s_nUseCnt <= 0 )
>         {
>           I2C_DBG1("DS75_DRIVER  : i2c driver can't be released!\n");
>           return -EIO;
>         }
>       else
>         {
>           I2C_DBG1("DS75_DRIVER  : Release Successful!\n");
>           s_nUseCnt--;
>           if( s_nUseCnt == 0 )
>             {
>               s_bI2CDevOpen = 0;
>               I2C_DBG1("DS75_DRIVER  : I2C Driver is Closed!\n");
>                 }
>         }
>       return 0;
>     }
>   else
>     {
>       I2C_DBG1("DS75_DRIVER  : Release Fail! (Device is Not Open)\n");
>       return -EIO;
>     }
> }
> 
> /*
>  This function will read the Temperature from the device and copies to
> user space
> */
> static int ds75_temp_read(struct ds75_msg_t *pData)
> {
>      //unsigned char buffer[4];
>      signed char buffer[4];
>      int ret;
>      buffer[0]=0;  /* Writing 0 in to Pointer register. --> Temprature
> read register */
>      if ((ret = i2c_master_send(&ds75->i2c_client,buffer,2)) !=2)
>      {
>          I2C_DBG2("DS75_DRIVER  : Error writing to I2C ret = %d
> \n",ret);
>                      return -1;
>      }
>     
>      /* reading from the temperature read register */
>      if (i2c_master_recv(&ds75->i2c_client,buffer,2)!= 2)
>      {
>          I2C_DBG1("DS75_DRIVER  : Error reading from I2C\n");
>                      return -1;
>      }
>     
>      //I2C_DBG3("DS75_DRIVER: data[0] = %d, data[1] = %d
> \n",buffer[0],buffer[1]);
>         //I2C_DBG3("DS75_DRIVER: data[0] = %d, data[1] = %d
> \n",buffer[0],buffer[1]);
>     
>      /* Copy User Memory Area */
>            if(copy_to_user(pData->ReadData,buffer, 2 ) != 0)
>            {
>               I2C_DBG1("DS75_DRIVER  : error in copying to user
> space");
>               return -1;
>            }
> 
>      return 0;  /* Success */
>     
> }
> 
> 
> static int ds75_iotcl(struct inode *inode, struct file *flip, unsigned
> int cmd, unsigned long arg)
> {
>         int nRetVal = 0;
>        
>         if( ((struct ds75_msg_t *)arg) == NULL ){
>                 I2C_DBG1("DS75_DRIVER  : ioctl Message Buff must not
> be NULL\n");
>                 return -EFAULT;
>         }
> 
>         switch(cmd){
>                 case TEMP_READ:
>                         I2C_DBG2("DS75_DRIVER  : ioctl TEMP_READ cmd %
> d\n",cmd);
>                         nRetVal = ds75_temp_read((struct ds75_msg_t *)
> arg);
>                         break;
>      
>                 default:
>                         /* Error! */
>                         I2C_DBG1("DS75_DRIVER  : Command  not
> implemented\n");
>                         nRetVal = -EIO;
>                         break;
>         }
>         return nRetVal;
> }
> 
> 
> /*
>  *  i2c_attach_client - tries to detect and initialize slics
> */
> int ds75_attach_client(struct ds75_data * ds75, struct i2c_adapter
> *adapter)
> {
>         struct i2c_client * client;
> 
>         /* register i2c client */
>         client = &ds75->i2c_client;
>         client->adapter = adapter;
>         client->driver = &ds75_driver;
> //      client->flags = I2C_CLIENT_ALLOW_USE;
>   client->addr = DS75_ADDR;       
>   strlcpy(client->name, "DS75", I2C_NAME_SIZE);
>         i2c_set_clientdata(client, ds75);
>  
>         if (i2c_attach_client(client))
>      return -1;
>  
>         printk (KERN_INFO DS75_DRIVER_NAME ": I2C client attached\n");
>         return 0;
> }
> 
> /*
>  *  i2c_attach_adapter - initializes the maxim driver
> */
> int ds75_attach_adapter(struct i2c_adapter *adapter)
> {
>         /* allocate maxim_data structure */
>         ds75 = kmalloc(sizeof (struct ds75_data), GFP_KERNEL);
>         if (ds75 == NULL)
>         {
>            printk (KERN_ERR "Unable to allocate memory for ds75 temp
> sensor driver\n");
>            goto err0;
>         }
>         memset(ds75, 0, sizeof(struct ds75_data));
> 
>         /* Attach Spi Client */
>         if (ds75_attach_client(ds75, adapter) != 0)
>         {
>            printk (KERN_ERR "No ds75 device detected\n");
>            goto err1;
>         }
> 
>         return 0;
> 
> err1:
>         kfree(ds75);
> err0:
>         return -1;
> }
> 
> /*
>  *  i2c_detach_client - cleans up the maxim driver
> */
> int ds75_detach_client(struct i2c_client *client)
> {
>         struct ds75_data *ds75 = i2c_get_clientdata(client);
> 
>         if (ds75->owned_irq)
>         {
>                 free_irq(ds75->irq, ds75);
>                 ds75->owned_irq = 0;
>                
>         }
> 
>         i2c_detach_client(&ds75->i2c_client);
>    
>         kfree (ds75);      // Free the kernel memory */
> 
>         return 0;
> }
> 
> 
> 
> 
> /*
>  * Temperature sensor DS75 init -
>  *
>  */
> int __init ds75_init(void)
> {
>         int rc;
>         rc = i2c_add_driver(&ds75_driver);
>         if (rc)
>         {
>                 printk (KERN_ERR DS75_DRIVER_NAME ": unable to add
> driver\n");
>                 return rc;
>         }
> 
>         rc = register_chrdev (DS75_DEVICE_MAJOR_NUM, DS75_DRIVER_NAME,
> &tmpsensor_fops);
>         if (rc)
>         {
>                 printk (KERN_ERR DS75_DRIVER_NAME ": unable to
> register char device\n");
>                 return rc;
>         }
> 
>         return 0;
> }
> 
> /**
>  * maxim _exit -
>  *
>  *
>  */
> void __exit ds75_exit(void)
> {
>         unregister_chrdev (DS75_DEVICE_MAJOR_NUM, DS75_DRIVER_NAME);
> 
>         i2c_del_driver(&ds75_driver);
> }
> 
> MODULE_AUTHOR("xxxx");
> MODULE_DESCRIPTION("DS75 I2C driver");
> MODULE_LICENSE("GPL");
> 
> module_init(ds75_init);
> module_exit(ds75_exit);
> 
> 
> Regards,
> Smitha 
> 
> Please do not print this email unless it is absolutely necessary. 
> 
> The information contained in this electronic message and any
> attachments to this message are intended for the exclusive use of the
> addressee(s) and may contain proprietary, confidential or privileged
> information. If you are not the intended recipient, you should not
> disseminate, distribute or copy this e-mail. Please notify the sender
> immediately and destroy all copies of this message and any
> attachments. 
> 
> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence of
> viruses. The company accepts no liability for any damage caused by any
> virus transmitted by this email. 
> 
> www.wipro.com
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
