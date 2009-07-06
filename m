Return-Path: <mzaturenskiy.st@gmail.com>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 06064B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 04:50:30 +1000 (EST)
Received: by qw-out-1920.google.com with SMTP id 5so1712416qwf.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 06 Jul 2009 11:50:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A5244B6.7030800@freescale.com>
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<97dd5fd20907020643s52cc65aah8ee315c3592d5e1@mail.gmail.com>
	<4A4CBC0C.1040001@mlbassoc.com>
	<97dd5fd20907020927v2680a7f8m2657193394bd6323@mail.gmail.com>
	<97dd5fd20907021142i663de6aavc093fbd6ac5025c@mail.gmail.com>
	<1ba63b520907021338n3c0d6d33g11d4934ccc538a94@mail.gmail.com>
	<97dd5fd20907021438ve8c72b9g168e4aa22e9f2f9f@mail.gmail.com>
	<4A4D2B70.1030505@freescale.com>
	<97dd5fd20907061129k67d2404m7e2a2c8fd8a71503@mail.gmail.com>
	<4A5244B6.7030800@freescale.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Mon, 6 Jul 2009 13:50:08 -0500
Message-ID: <97dd5fd20907061150o303418a3m3967650433fbb061@mail.gmail.com>
Subject: Re: RAMDISK on EP88xc
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> After doing this testing I have a side question:
>> If I modify just arch/powerpc/configs/ep88x_defconfig, not all changes
>> are reflected in the resulting .config when i do "make
>> ep88x_defconfig; make uImage". I ended up having to modify
>> arch/powerpc/Kconfig, arch/powerpc/configs/ep88xc_defconfig,
>> fs/ext2/Kconfig and init/Kconfig to get "make ep88x_defconfig; make
>> uImage" to create a properly configured image, but this really doesn't
>> feel right. What's the proper way to set up a defconfig?
>
> What changes are you trying to make to the config, and what did you change
> in the Kconfig files?
>

****************************************************
in arch/powerpc/Kconfig:
+	config BLK_DEV_LOOP
+		tristate
+		default y

+	config BLK_DEV_RAM
+		tristate
+		default y

+	config BLK_DEV_RAM_COUNT
+		int
+		default 16

+	config BLK_DEV_RAM_SIZE
+		int
+		default 32768
****************************************************
in arch/powerpc/configs/ep88xc_defconfig:
+	CONFIG_BLK_DEV = y
-	CONFIG_BLK_DEV is not set
-	CONFIG_BLK_DEV_INITRD is not set
-	CONFIG_EXT2_FS is not set
****************************************************
in fs/ext2/Kconfig/"config EXT2_FS":
+	default y
****************************************************
in init/Kconfig/"config BLK_DEV_INITRD":
+	default y
****************************************************

If I make changes just to arch/powerpc/configs/ep88xc_defconfig they
don't seem to be propagated to the resulting configuration when using
"make ep88xc_defconfig"
