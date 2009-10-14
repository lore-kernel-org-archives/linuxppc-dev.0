Return-Path: <shep@xplot.org>
Received: from alva.home (dsl092-066-146.bos1.dsl.speakeasy.net [66.92.66.146])
	by ozlabs.org (Postfix) with ESMTP id 13811B7E2B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 06:23:02 +1100 (EST)
From: Tim Shepard <shep@alum.mit.edu>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] therm_adt746x: Don't access non-existing register 
In-reply-to: Your message of Wed, 14 Oct 2009 17:31:32 +0200.
	<20091014173132.2894d0fd@hyperion.delvare>
Date: Wed, 14 Oct 2009 14:59:20 -0400
Message-Id: <E1My94C-0002GE-00@alva.home>
Sender: Tim Shepard <shep@xplot.org>
Cc: Colin Leroy <colin@colino.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Jean,

I tried one reboot with your patch, failed as usual.
(Patch sounds like a good idea though.)

			-Tim Shepard
			 shep@alum.mit.edu



tree<11>$ git describe
v2.6.31.1-6-g0b193bc
tree<12>$ git diff HEAD^ HEAD
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 0554dae..bf9ed2d 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -366,7 +366,7 @@ static int probe_thermostat(struct i2c_client *client,
        i2c_set_clientdata(client, th);
        th->clt = client;
 
-       rc = read_reg(th, 0);
+       rc = read_reg(th, CONFIG_REG);
        if (rc < 0) {
                dev_err(&client->dev, "Thermostat failed to read config!\n");
                kfree(th);
tree<13>$ dmesg | head
Using PowerMac machine description
Total memory = 1536MB; using 4096kB for hash table (at cfc00000)
Linux version 2.6.31.1-00006-g0b193bc (shep@tree) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #9 Wed Oct 14 13:41:40 EDT 2009
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0xd9
Mapped at 0xff7c0000
Found a Intrepid mac-io controller, rev: 0, mapped at 0xff740000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerBook G4 15"
console [udbg0] enabled
Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->1
tree<14>$ dmesg | grep adt
adt746x: version 1 (supported)
adt746x: Thermostat bus: 0, address: 0x2e, limit_adjust: 0, fan_speed: -1
therm_adt746x 7-002e: Thermostat failed to read config!
tree<15>$ 
