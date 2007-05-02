Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 6CA0ADDF6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 07:08:35 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so251933ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 02 May 2007 14:08:33 -0700 (PDT)
Message-ID: <528646bc0705021408o1e1f25d7pa81905081d06ed8e@mail.gmail.com>
Date: Wed, 2 May 2007 15:08:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Peter Korsgaard" <jacmet@sunsite.dk>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Using Cypress EZ-Host on ML403/5
In-Reply-To: <528646bc0704301223q2024505ah5308147ba6eead0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4623A197.6000104@computing.dundee.ac.uk>
	<528646bc0704160932k2038090al8c0b8e5420422545@mail.gmail.com>
	<87zm54mt3j.fsf@sleipner.barco.com>
	<528646bc0704190717o14da4b58r5ef69a8e77ade198@mail.gmail.com>
	<87vefsmoaj.fsf@sleipner.barco.com>
	<528646bc0704190750r4b6d76y72a862c249fa0520@mail.gmail.com>
	<9305ca410704240042w7f8b12fau331a6407f45be74c@mail.gmail.com>
	<528646bc0704240637sd3797a2q5ae48db19155ba61@mail.gmail.com>
	<9305ca410704270141y66928deyab59300b8c5ccb95@mail.gmail.com>
	<528646bc0704301223q2024505ah5308147ba6eead0a@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/30/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 4/27/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> > On 4/24/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> > > > Anyway, here it is. It is structured as a base driver with
> > > > configurable host/peripheral support on top. The host part works
> > > > pretty ok, but the scheduling code can still be improved. Please
> > > > ignore the peripheral part for now.
> > >
> > > Awesome, thank you!  I'll try it out ASAP.
> >
> > Did you have a chance to try it out yet?

Hey Peter,

I've got it running on my board now after figuring out how to wire up
external interrupts in EDK.  :-)

Good success with keyboards and mice.  Events come through no problem.

Some block devices seem to be giving me grief.  I have no problem with
my SanDisk ImageMate CF reader.  However, I've got a SanDisk Curzer
Micro that gets reset during transfers.  Is this something you've seen
before?  Log output is below.

I've also got a QuickCam Messinger that I'm going to test isochronos
transfers with as well.

Cheers,
g.

/mnt #
/mnt # [ 2358.173508] usb 1-1.1: new full speed USB device using
c67x00 and address 15
[ 2358.309263] usb 1-1.1: configuration #1 chosen from 1 choice
[ 2358.318978] scsi4 : SCSI emulation for USB Mass Storage devices
[ 2358.328546] usb-storage: device found at 15
[ 2358.332860] usb-storage: waiting for device to settle before scanning
[ 2363.348145] scsi 4:0:0:0: Direct-Access     SanDisk  U3 Cruzer
Micro  2.18 PQ: 0 ANSI: 2
[ 2363.367956] SCSI device sda: 990865 512-byte hdwr sectors (507 MB)
[ 2363.379943] sda: Write Protect is off
[ 2363.383721] sda: Mode Sense: 03 00 00 00
[ 2363.387701] sda: assuming drive cache: write through
[ 2363.416940] SCSI device sda: 990865 512-byte hdwr sectors (507 MB)
[ 2363.428944] sda: Write Protect is off
[ 2363.432709] sda: Mode Sense: 03 00 00 00
[ 2363.436691] sda: assuming drive cache: write through
[ 2363.441730]  sda: sda1
[ 2363.465064] sd 4:0:0:0: Attached scsi removable disk sda
[ 2363.475029] usb-storage: device scan complete

/mnt #
/mnt # dd if=/dev/sda of=/dev/null bs=512 count=2048
[ 2390.851453] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2391.091406] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2391.331377] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2391.571349] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2391.811317] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2392.051286] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2392.173340] sd 4:0:0:0: SCSI error: return code = 0x00070000
[ 2392.179076] end_request: I/O error, dev sda, sector 0
[ 2392.184169] Buffer I/O error on device sda, logical block 0
[ 2392.189797] Buffer I/O error on device sda, logical block 1
[ 2392.195419] Buffer I/O error on device sda, logical block 2
[ 2392.201046] Buffer I/O error on device sda, logical block 3
[ 2392.206667] Buffer I/O error on device sda, logical block 4
[ 2392.212290] Buffer I/O error on device sda, logical block 5
[ 2392.217917] Buffer I/O error on device sda, logical block 6
[ 2392.223537] Buffer I/O error on device sda, logical block 7
[ 2392.229179] Buffer I/O error on device sda, logical block 8
[ 2392.234804] Buffer I/O error on device sda, logical block 9
[ 2392.331253] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2392.543226] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2392.755200] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2392.967174] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2393.179147] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2393.391121] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2393.513110] sd 4:0:0:0: SCSI error: return code = 0x00070000
[ 2393.518840] end_request: I/O error, dev sda, sector 0
dd: /dev/sda: Input/output error
/mnt # time dd if=/dev/sda of=/dev/null bs=512 count=2048
[ 2442.613020] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2442.852988] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2443.092959] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2443.332929] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2443.572902] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2443.812869] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2443.934899] sd 4:0:0:0: SCSI error: return code = 0x00070000
[ 2443.940624] end_request: I/O error, dev sda, sector 0
[ 2443.945717] printk: 30 messages suppressed.
[ 2443.949940] Buffer I/O error on device sda, logical block 0
[ 2443.955565] Buffer I/O error on device sda, logical block 1
[ 2443.961190] Buffer I/O error on device sda, logical block 2
[ 2443.966817] Buffer I/O error on device sda, logical block 3
[ 2443.972437] Buffer I/O error on device sda, logical block 4
[ 2443.978061] Buffer I/O error on device sda, logical block 5
[ 2443.983688] Buffer I/O error on device sda, logical block 6
[ 2443.989309] Buffer I/O error on device sda, logical block 7
[ 2443.994952] Buffer I/O error on device sda, logical block 8
[ 2444.000576] Buffer I/O error on device sda, logical block 9
[ 2444.096835] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2444.308808] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2444.520781] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2444.732771] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2444.944730] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2445.156704] usb 1-1.1: reset full speed USB device using c67x00 and
address 15
[ 2445.278663] sd 4:0:0:0: SCSI error: return code = 0x00070000
[ 2445.284390] end_request: I/O error, dev sda, sector 0
dd: /dev/sda: Input/output error
Command exited with non-zero status 1
real    0m 2.81s
user    0m 0.00s
sys     0m 0.02s
/mnt #

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
