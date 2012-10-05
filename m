Return-Path: <zinosat@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AB092C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 18:54:02 +1000 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kq12so1492885pab.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2012 01:54:00 -0700 (PDT)
MIME-Version: 1.0
Sender: zinosat@gmail.com
In-Reply-To: <CAKpAL0m3YnsbbGxL+ejfyE4zfGE5LD9Qxb7oobHVaAZGE1_Jnw@mail.gmail.com>
References: <11976036.82651349353479389.JavaMail.defaultUser@defaultHost>
 <62666FBA-F62E-44B7-814E-0718AE957EC0@kernel.crashing.org>
 <CAKpAL0m3YnsbbGxL+ejfyE4zfGE5LD9Qxb7oobHVaAZGE1_Jnw@mail.gmail.com>
Date: Fri, 5 Oct 2012 10:54:00 +0200
Message-ID: <CAKpAL0mErR3vR4AdSAT_vJG_kM=GvHnZR+b3dtSCN0GMU56pAw@mail.gmail.com>
Subject: Fwd: PCI device not working
From: Davide Viti <zinosat@tiscali.it>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(just realized I did not send this to the mailing list: sorry for the noise)

Hi Kumar,

2012/10/4 Kumar Gala <galak@kernel.crashing.org>:
>
> On Oct 4, 2012, at 7:24 AM, Davide Viti wrote:
>
>> Hi,
>> it turns out that if define CONFIG_PCI_NOSCAN in u-boot (as per [1]), the
>> device behind the second controller is detected by the  Linux kernel.
>>
>> Would
>> you suggest any particular patch I should apply to fix this (I'm using kernel
>> 2.6.34)
>>
>> thanx alot in advance
>> Davide
>>
>> [1] http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/20140
>
> My suggestion would be to try and dump all the controller registers between the case that works and doesn't and compare.  There's some minor setting difference that I'm guessing is causing issues.
>
> - k

Here's a diff for the configurations for the controller, obtained via

hexdump -C /sys/bus/pci/devices/0001\:02\:00.0/config

--- cfg0_2_NOK.txt      2012-10-05 09:37:44.854607000 +0200
+++ cfg0_2_OK.txt       2012-10-05 09:36:58.337399000 +0200

 00000400  00 00 00 00 16 00 00 00  e2 04 00 00 00 00 00 00  |................|
 00000410  04 00 00 00 01 00 00 00  00 00 00 00 40 40 00 00  |............@@..|
 00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00000430  00 00 00 00 00 00 00 00  21 81 9e 00 1a 90 01 00  |........!.......|
+00000430  00 00 00 00 00 00 00 00  21 81 9e 00 83 20 08 00  |........!.... ..|
 00000440  10 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000450  ce d7 14 00 20 1e fc 01  00 00 00 00 5c 0c 00 00  |.... .......\...|
 00000460  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000470  57 19 00 01 11 00 20 0b  00 00 00 00 01 00 00 00  |W..... .........|
 00000480  44 3d 00 00 00 00 00 00  f0 07 00 00 00 00 00 00  |D=..............|
 00000490  c0 07 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-000004a0  00 00 00 00 00 00 00 00  00 00 00 00 3c 01 00 00  |............<...|
+000004a0  00 00 00 00 00 00 00 00  00 00 00 00 7e 01 00 00  |............~...|
 000004b0  00 00 00 00 00 00 00 00  28 04 01 80 85 20 00 00  |........(.... ..|
 000004c0  ff 00 00 00 00 00 00 00  00 00 00 00 11 00 00 00  |................|
 000004d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 000004e0  00 00 00 00 01 01 00 00  01 01 00 00 00 00 00 00  |................|
-000004f0  0a 00 00 00 01 00 20 04  00 00 00 00 79 47 0e eb  |...... .....yG..|
+000004f0  4a 00 00 01 03 00 00 04  00 00 00 00 01 00 01 00  |J...............|
 00000500  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000510  00 00 00 00 00 00 00 00  21 01 00 00 00 00 00 00  |........!.......|
 00000520  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

Hope this mail client will not screw up the text...
Just in case,
I've pasted the entire register dumps to [1].

thank you so much for your time,
D.

[1] http://pastebin.com/zzAtzCeS
