Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D1869DDD05
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 15:33:19 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2E4X5Al021768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 05:33:11 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HRLAf-0009cx-Nu
	for linuxppc-embedded@ozlabs.org; Wed, 14 Mar 2007 05:33:05 +0100
Date: Wed, 14 Mar 2007 05:33:05 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem in compiling a kernel module
Message-ID: <20070314043305.GB27011@server.idefix.lan>
References: <20070313043050.GB82243@server.idefix.lan>
	<513703.69187.qm@web302.biz.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
In-Reply-To: <513703.69187.qm@web302.biz.mail.mud.yahoo.com>
Sender: Matthias Fechner <idefix@fechner.net>
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ben,

* Ben Warren <bwarren@qstreams.com> [13-03-07 05:55]:
> Is there any chance that you qualify private data as
> __init within the driver?  Can you post the cleanup()
> function and any private (static) functions that it
> calls?

no problem, I attached the file. It is bery basic from now and it is
not written very well, but it should have all necessary parts in it.

PS: It's not necessary to CC me I'm on the list :)

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook

--liOOAslEiF7prFVr
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="max6633.c"

/*
  driver to support MAX6633
*/

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include <linux/mutex.h>

#define MAX6633_VERSION 0.1
#define MAX6633_DATE 20070301

//#define MAX633_SYSCTL_FUNC1 0x1000
//#define MAX6633_REG_GENERIX 0x0

int max6633_attach_adapter(struct i2c_adapter *adapter);
int max6633_detach_client(struct i2c_client *client);
int max6633_detect_client(struct i2c_adapter *adapter, int address, int kind);
void max6633_cleanup(void);

static struct i2c_driver max6633_driver = {
   .driver = {
      .name = "max6633",
   },
   .attach_adapter = max6633_attach_adapter,
   .detach_client = max6633_detach_client,
//   .command = &max6633_command /* may be NULL */
};

struct max6633_data 
{
      struct i2c_client client;
      struct mutex update_lock;
      int sysctl_id; /* To keep the /proc directory entry */
      
      char valid;
      u16 temp;
      
      unsigned long last_updated;
};

/// TODO: create the function func1 or rename it here
/*
static ctl_table max6633_dir_table_template[]= {
   { MAX633_SYSCTL_FUNC1, "func1", NULL, 0, 0644, NULL, &i2c_proc_real,
     &i2c_sysctl_real, NULL, &max6633_temp },
   { 0 }
};
*/

void max6633_temp(struct i2c_client *client, int operation, int ctl_name,
		  int *nrels_mag, long *results)
{
   return;
}

int max6633_read_value(struct i2c_client *client, u8 reg)
{
   return i2c_smbus_read_word_data(client,reg);
}

int max6633_write_value(struct i2c_client *client, u8 reg, u16 value)
{
   return i2c_smbus_write_word_data(client,reg,value);
}

/// TODO: check all possible addresses
/* scan 0x40, 0x41 and 0x42 */
static unsigned short normal_i2c[] = {
   0x40, 0x41, 0x42, I2C_CLIENT_END
};

/* Magic definition of all other variables and things */
I2C_CLIENT_INSMOD;

int max6633_attach_adapter(struct i2c_adapter *adapter)
{
   return i2c_probe(adapter, &addr_data,max6633_detect_client);
}

int max6633_detect_client(struct i2c_adapter *adapter, int address, int kind)
{
   int err=0;
   //int i;
   struct i2c_client *new_client;
   struct max6633_data *data;

   /* Let's see wheter this adapter can support what we need */
   if(!i2c_check_functionality(adapter,I2C_FUNC_SMBUS_WORD_DATA |
			       I2C_FUNC_SMBUS_BYTE_DATA))
   {
      printk("max6633: Adapter doesn't support functionality.\n");
      goto ERROR0;
   }
   
//   const char *type_name="";
   
   /* OK. For now, we presume we have a valid client. We no create the
      client structure, even though we cannot fill it completely yet.
      But it allows us to access several i2c functions safely */
   if(!(data=kzalloc(sizeof(struct max6633_data), GFP_KERNEL)))
   {
      err=-ENOMEM;
      goto ERROR0;
   }
   
   new_client=&data->client;
   i2c_set_clientdata(new_client, data);
   
   new_client->addr=address;
   new_client->adapter=adapter;
   new_client->driver=&max6633_driver;
   new_client->flags=0;
   
   /* Now, we do the remaining detection. If no `force' parameter is used. */

   /* First, the generic detection (if any), that is skipped if any force
      parameter was used. */
   if(kind <0)
   {
      /* The bellow is of course bogus */
      /*
      if(max6633_read_value(new_client, MAX633_REG_GENERIC) != MAX633_GENERIC_VALUE)
	 goto ERROR1;
      */
   }
   
   /* Fill in the remaining client fields. */
   strcpy(new_client->name,"max6633");
   data->valid=0;
   //init_MUTEX(&data->update_lock); /* only if you use this field */

   /* Any other initialisation in data must be done here too. */

   /* Tell the i2c layer a new client has arrived */
   if((err=i2c_attach_client(new_client)))
      goto ERROR3;
   
//   type_name="chip1"; /* for /proc entry */
   
   /* Register a new directory entry with module sensors. See above for
      the template structure. */
/*   if((i=i2c_register_entry(new_client, type_name,
			    max6633_dir_table_template, THIS_MODULE)) < 0)
   {
      err=i;
      goto ERROR4;
   }
*/
   //data->sysctl_id=i;
   
   /* This function can write default values to the client registers, if
      needed. */
   //max6633_init_client(new_client);

   printk(KERN_INFO "Found max6633 I2C temperature sensor.\n");
   return 0;
   
   /* OK, this is not exactly good programming practice, usually. But it is
      ver code-efficient in this case. */

//  ERROR4:
//   i2c_detach_client(new_client);
  ERROR3:
//  ERROR2:
//  ERROR1:
   kfree(data);
  ERROR0:
   return err;
}

int max6633_detach_client(struct i2c_client *client)
{
   int err;
   
   /* Try to detach the client from i2c space */
   if((err=i2c_detach_client(client)))
      return err;
   
   kfree(i2c_get_clientdata(client));
   return 0;
}

/* Keep track of how far we got in the initialisation process. If several
   things have to initialized and we fail halfway, only those things
   have to be cleared up! */
static int __initdata max6633_initialized = 0;

static int __init max6633_init(void)
{
   int res;
   printk("max6633 version %f (%d)\n", MAX6633_VERSION, MAX6633_DATE);
   
   if((res=i2c_add_driver(&max6633_driver)))
   {
      printk("max6633: Driver registration failed, module not inserted.\n");
      max6633_cleanup();
      return res;
   }
   max6633_initialized ++;
   return 0;
}

void max6633_cleanup(void)
{
   int res;
   if(max6633_initialized==1)
   {
      if((res=i2c_del_driver(&max6633_driver)))
      {
	 printk("max6633: Driver registration failed, module not removed.\n");
	 return;
      }
      max6633_initialized --;
   }
}

MODULE_AUTHOR("Matthias Fechner <idefix@fechner.net>");
MODULE_DESCRIPTION("Driver for MAX6633 temperature I2C device.");

module_init(max6633_init);
module_exit(max6633_cleanup);


   

--liOOAslEiF7prFVr--
