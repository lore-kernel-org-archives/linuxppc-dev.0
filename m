Subject: Re: 2.6.0-test3-bk35 -- drivers/i2c/i2c-keywest.c:513: error:
	structure has no member named `name'
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308201428.05756.miles.lane@comcast.net>
References: <200308201428.05756.miles.lane@comcast.net>
Content-Type: multipart/mixed; boundary="=-61ouoPXyBT4WHpbWUlmi"
Message-Id: <1061457144.3144.61.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 21 Aug 2003 11:12:25 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-61ouoPXyBT4WHpbWUlmi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 2003-08-20 at 23:28, Miles Lane wrote:
>   CC      drivers/i2c/i2c-keywest.o
> drivers/i2c/i2c-keywest.c: In function `create_iface':
> drivers/i2c/i2c-keywest.c:513: error: structure has no member named `name'
> drivers/i2c/i2c-keywest.c:526: error: structure has no member named `name'
> make[2]: *** [drivers/i2c/i2c-keywest.o] Error 1

FWIW, this patch fixes this and a similar build failure.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

--=-61ouoPXyBT4WHpbWUlmi
Content-Disposition: attachment; filename=linuxppc-2.6.0-test3.diff
Content-Type: text/x-patch; name=linuxppc-2.6.0-test3.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -up -r linuxppc-2.6.0-test3/drivers/i2c/i2c-keywest.c linuxppc-2.6.0-test3-md/drivers/i2c/i2c-keywest.c
--- linuxppc-2.6.0-test3/drivers/i2c/i2c-keywest.c	2003-08-20 10:26:31.000000000 +0200
+++ linuxppc-2.6.0-test3-md/drivers/i2c/i2c-keywest.c	2003-08-20 14:48:23.000000000 +0200
@@ -510,7 +510,7 @@ create_iface(struct device_node* np)
 		struct keywest_chan* chan = &iface->channels[i];
 		u8 addr;

-		sprintf(chan->adapter.dev.name, "%s %d", np->parent->name, i);
+		sprintf(chan->adapter.name, "%s %d", np->parent->name, i);
 		chan->iface = iface;
 		chan->chan_no = i;
 		chan->adapter.id = I2C_ALGO_SMBUS;
@@ -523,7 +523,7 @@ create_iface(struct device_node* np)
 		rc = i2c_add_adapter(&chan->adapter);
 		if (rc) {
 			printk("i2c-keywest.c: Adapter %s registration failed\n",
-				chan->adapter.dev.name);
+				chan->adapter.name);
 			i2c_set_adapdata(&chan->adapter, NULL);
 		}
 		if (probe) {
diff -up -r linuxppc-2.6.0-test3/sound/ppc/keywest.c linuxppc-2.6.0-test3-md/sound/ppc/keywest.c
--- linuxppc-2.6.0-test3/sound/ppc/keywest.c	2003-08-20 10:27:44.000000000 +0200
+++ linuxppc-2.6.0-test3-md/sound/ppc/keywest.c	2003-08-20 14:57:28.000000000 +0200
@@ -50,7 +50,7 @@ struct i2c_driver keywest_driver = {


 #ifndef i2c_device_name
-#define i2c_device_name(x)	((x)->dev.name)
+#define i2c_device_name(x)	((x)->name)
 #endif

 static int keywest_attach_adapter(struct i2c_adapter *adapter)

--=-61ouoPXyBT4WHpbWUlmi--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
