Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 46A936861B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Oct 2005 02:15:09 +1000 (EST)
Message-ID: <435D088C.9060000@ru.mvista.com>
Date: Mon, 24 Oct 2005 20:15:08 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20051024170707.5068be0a.ajz@cambridgebroadband.com>
In-Reply-To: <20051024170707.5068be0a.ajz@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: m82xxhci USB driver problems
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Maybe there's something with SOF generation - check if RCCR[EIE] is set.
Just a pure guess...
Alex Zeffertt wrote:
> Hi list,
> 
> I'm trying to get the m82xxhci USB host controller driver working on
> my MPC8272ADS board, and linux-2.4.25.
> 
> I can compile and modprobe the module.  When I insert a USB pen drive
> I get the following message:
> 
> 	# hub.c: new USB device m8xxhci-1, assigned address 4
> 	Manufacturer:
> 	Product: USB Disk Pro
> 	SerialNumber: 07531E630012
> 	scsi0 : SCSI emulation for USB Mass Storage devices
> 
> Which looks okay.  But after a long delay I get:
> 	
> 	# usb_control/bulk_msg: timeout
>                                 
> Then after another delay:
> 	
> 	# usb-storage: host_reset() requested but not implemented
> 	#
> 
> 
> Then after another delay:
> 
> 	# scsi: device set offline - command error recover failed: host 0
> 	channel 0 id 0 lun 0
> 
> After this final message, but not before, the pen drive device appears
> in /proc/bus/usb/devices:
> 
> 	# cat /proc/bus/usb/devices
> 	T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 1
> 	B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> 	D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> 	P:  Vendor=0000 ProdID=0000 Rev= 0.00
> 	S:  Product=USB MPC8xx Root Hub
> 	S:  SerialNumber=f0011b60	
> 	C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> 	I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> 	E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 	T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> 	D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> 	P:  Vendor=0d7d ProdID=0120 Rev= 1.00
> 	S:  Manufacturer=
> 	S:  Product=USB Disk Pro
> 	S:  SerialNumber=07531E630012
> 	C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
> 	I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=04 Prot=00
> 	Driver=usb-storage E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> 	E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> 	E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=1ms
> 
> 
> 
> Does anybody have any idea what could be causing this problem?  The
> HCI is clearly able to communicate with the device because it
> identifies it.  But I don't know why the timeout should occur!
> 
> 
> Alex
> 
> 
> PS A possibly related problem: I have built sd_mod.o as a module, and
> I can modprobe sd_mod okay.  However, after I have run modprobe I
> still do not see an "sd" block device in /proc/devices.  I have no
> idea why though....
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely,
Vitaly
