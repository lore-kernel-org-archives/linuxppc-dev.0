From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <rhires@earthlink.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.18 kernel oops report
Date: Sun, 3 Mar 2002 15:12:38 +0100
Message-Id: <20020303141238.5998@smtp.wanadoo.fr>
In-Reply-To: <E16hY7m-0000EU-00@localhost>
References: <E16hY7m-0000EU-00@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hello! I'm not subscribed to this list, but I thought I'd send this along...I
>have a problem with kernel oopses. I'm running a Powermac G3 266 Desktop,
>with standard everything, except I've got a Voodoo3 card for my monitor and a
>PCI USB Card. I've got 392 (?) MB RAM, a SCSI Drive and two IDE drives. I'm
>running a stock 2.4.18 kernel that I got from kernel.org, and this oops has
>happened before on previous stock kernels (2.4.17 in particular). I'm sure
>that sound is part of the problem. I boot into Linux using BootX, and usually
>boot all the way into the MacOS (8.6) to get sound. Sometimes I have a hard
>crash, and when I boot back into Linux (going all the way into MacOS), I get
>kernel errors while fsck is doing its thing. If I just boot into Linux using
>the "Choose Your OS" panel at startup, fsck is able to proceed without any
>problem, but I also have no sound...and no oopses, either.
>
>I've run ksymoops through kern.log and syslog after the oops, but the syslog
>is more like what I think is necessary to be reported...if you need more, let
>me know directly, as I'm not a member of this list...I'm hesitant to send my
>System.map to the mailing list, it's kinda big!

It looks like something in macos is damaging the kernel, or a device is
still bus mastering, thus trashing memory, while linux loads. The best
way would be to fix the sound problem with BootX extension. What kind of
sound hardware do you have, awacs or burgundy ?

Can you try the following patch ? (it may applyh with a slight offset)

===== arch/ppc/kernel/pmac_feature.c 1.6 vs edited =====
--- 1.6/arch/ppc/kernel/pmac_feature.c	Fri Feb 22 01:10:43 2002
+++ edited/arch/ppc/kernel/pmac_feature.c	Sun Mar  3 17:10:01 2002
@@ -2041,10 +2045,20 @@
 		}
 	}

-	/* On all machines, switch sound off */
+	/* On all machines that support sound PM, switch sound off */
 	if (macio_chips[0].of_node)
 		pmac_do_feature_call(PMAC_FTR_SOUND_CHIP_ENABLE,
 			macio_chips[0].of_node, 0, 0);
+
+	/* While on some desktop G3s, we turn it back on */
+	if (macio_chips[0].of_node && macio_chips[0].type == macio_heathrow
+		&& (pmac_mb.model_id == PMAC_TYPE_GOSSAMER ||
+		    pmac_mb.model_id == PMAC_TYPE_SILK)) {
+		struct macio_chip* macio = &macio_chips[0];
+		MACIO_BIS(HEATHROW_FCR, HRW_SOUND_CLK_ENABLE);
+		MACIO_BIC(HEATHROW_FCR, HRW_SOUND_POWER_N);
+	}
+

 	/* On all machines, switch modem & serial ports off */
 	np = find_devices("ch-a");


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
