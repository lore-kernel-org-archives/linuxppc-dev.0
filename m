Return-Path: <ndrs.frsn@googlemail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1522B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Mar 2011 17:53:12 +1100 (EST)
Received: by iwc10 with SMTP id 10so10084359iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Mar 2011 23:53:09 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 24 Mar 2011 07:53:09 +0100
Message-ID: <AANLkTinv8JSC19+f7EDAkSbp3_=28PETL48suXR3yner@mail.gmail.com>
Subject: Autoupdate FIT image : wrong dtb load address
From: Andreas Friesen <ndrs.frsn@googlemail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello folks,

I'm trying to generate a autoupdate FIT-image.
I'm using u-boot 2010.12 / dtc 1.2.0. / Kernel 2.6.36.6 ;
Its work fine, but the load address of fdt-part is wrong.
Does anyone know what the problem is?

-------------- 8<--------------------
Auto-update from TFTP: trying update file 'mxa.itb'
Using FEC device
TFTP from server 192.168.1.10; our IP address is 192.168.1.58
Filename 'mxa.itb'.
Load address: 0x100000
Loading: #################################################################
	 #################################################################
	 #####################
done
Bytes transferred = 2210382 (21ba4e hex)
Processing update 'kernel@0' :sha1+
Erasing 0xff000000 - 0xff13ffff
.......... done
Erased 10 sectors
Copying to flash...done
Processing update 'rootfs@0' :sha1+
Erasing 0xff200000 - 0xff2bffff
...... done
Erased 6 sectors
Copying to flash...done
Processing update 'fpga@0' :sha1+
Erasing 0xfff60000 - 0xfff9ffff
.. done
Erased 2 sectors
Copying to flash...done
Processing update 'fdt@0' :sha1+
Error: end address (0x3c30c665) not in flash! <----------------- ??????????????
Error: can't flash update, aborting
Hit any key to stop autoboot:  0
-------------- 8<--------------------


Thanks in advance.
Andreas Friesen

PS : Hier is my its-source  file  and mkimage output :
-------------- 8<--------------------
/dts-v1/;

/ {
 	description = "Automatic Software Update: kernel, rootfs, FDT, FPGA ";
 	timestamp = <1300774787>;
	#address-cells = <1>;
 	images {
  		kernel@0 {
 			description = "linux kernel image";
 			data = /incbin/("./uImage");
 			arch = "ppc";
 			type = "firmware";
 			load = <0xFF000000>;
  			compression = "none";
  			hash@1 {
 				algo = "sha1";
 			};
 		};
  		rootfs@0 {
 			description = "RootFS image";
 			data = /incbin/("./rootfs.img");
 			arch = "ppc";
 			type = "firmware";
 			load = <0xFF200000>;
 			compression = "none";
  			hash@1 {
 				algo = "sha1";
 			};
 		};
 		fpga@0 {
 			description = "FPGA Firmware";
 			data = /incbin/("./fpga.bin");
 			arch = "ppc";
 			compression = "none";
 			type = "firmware";
 			load = <0xFFF60000>;
 			hash@1 {
 				algo = "sha1";
 			};
 		};
 		fdt@0 {
 			description = "FDT binary";
 			data = /incbin/("./mxa.dtb");
 			arch = "ppc";
 			compression = "none";
 			type = "firmware";
 			load = "<0xFFFE0000>"; <----------- !!!!!!!!!!!!!!!!!!!!!!
  			hash@1 {
  				algo = "sha1";
 			};
 		};
 	};

};
------------------------8<--------------------------
$ mkimage -f  mxa_autoupdate.its  mxa.itb
Registered Kirkwood Boot Image support
Registered Freescale i.MX 51 Boot Image support
Registered FIT Image support
Registered Default Image support
FIT format handling
Trying to execute "dtc -I dts -O dtb -p 500 mxa_autoupdate.its >
mxa_autoupdate.itb.tmp"
DTC: dts->dtb  on file "mxa_autoupdate.its"
Added timestamp successfully
FIT description: Automatic Software Update: kernel, rootfs, FDT, FPGA
Created:         Tue Mar 22 07:19:47 2011
 Image 0 (kernel@0)
  Description:  linux kernel image
  Type:         Firmware
  Compression:  uncompressed
  Data Size:    1222870 Bytes = 1194.21 kB = 1.17 MB
  Architecture: PowerPC
  Load Address: 0xff000000
  Hash node:    'hash@1'
  Hash algo:    sha1
  Hash value:   e619b777d20246fe5b4f5b6ed2ad6ebe44c54fdf
  Hash len:     20
 Image 1 (rootfs@0)
  Description:  RootFS image
  Type:         Firmware
  Compression:  uncompressed
  Data Size:    753664 Bytes = 736.00 kB = 0.72 MB
  Architecture: PowerPC
  Load Address: 0xff200000
  Hash node:    'hash@1'
  Hash algo:    sha1
  Hash value:   eaf7b46387c0a912b81cb1cd38f8af616ed746a6
  Hash len:     20
 Image 2 (fpga@0)
  Description:  FPGA Firmware
  Type:         Firmware
  Compression:  uncompressed
  Data Size:    212392 Bytes = 207.41 kB = 0.20 MB
  Architecture: PowerPC
  Load Address: 0xfff60000
  Hash node:    'hash@1'
  Hash algo:    sha1
  Hash value:   65a54dc977a7287c499816108bc18eb19989aa0e
  Hash len:     20
 Image 3 (fdt@0)
  Description:  FDT binary
  Type:         Firmware
  Compression:  uncompressed
  Data Size:    20000 Bytes = 19.53 kB = 0.02 MB
  Architecture: PowerPC
  Load Address: 0x3c307846  <----------------- ???????????????????????
  Hash node:    'hash@1'
  Hash algo:    sha1
  Hash value:   067d8484ef45bfb0efe9d3b1caf17e0f37748aa4
  Hash len:     20
Can't get configurations parent node '/configurations' (FDT_ERR_NOTFOUND)

--------- >8 --------------
