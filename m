Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 825BBDDE06
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 01:43:42 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n44FdwgC024532
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 11:39:58 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n44FhJeH1351810
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 11:43:19 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n44FhIPT002074
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 09:43:19 -0600
Date: Mon, 4 May 2009 11:42:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Need a patch tested on a windtunnel powermac
Message-ID: <20090504154208.GC14017@zod.rchland.ibm.com>
References: <18936.58163.872136.772820@cargo.ozlabs.ibm.com>
	<20090430002448.GA5208@hansolo.jdub.homelinux.org>
	<20090430191707.GB2424@yoda.jdub.homelinux.org>
	<20090504145232.GB14017@zod.rchland.ibm.com>
	<20090504174001.5429769b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090504174001.5429769b@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 04, 2009 at 05:40:01PM +0200, Jean Delvare wrote:
>Hi Josh,
>> Ok, installed 2.6.30-rc4 plus Jean's patch and it appears to do something
>> correctly:
>> 
>> [jwboyer@localhost macintosh]$ sudo modprobe therm_windtunnel
>> [jwboyer@localhost macintosh]$ dmesg
>> <snip>
>> DS1775 digital thermometer [@49]
>> Temp: 52.5 C  Hyst: 75.0 C  OS: 80.0 C
>> ADM1030 fan controller [@2c]
>> Reducing overheating limit to 65.0 C (Hyst: 60.0 C)
>> CPU-temp: 52.9 C, Case: 31.3 C,  Fan: 0 (tuned -11)
>> [jwboyer@localhost macintosh]$ uname -a
>> Linux localhost.localdomain 2.6.30-rc4 #1 SMP Mon May 4 10:20:39 EDT 2009 ppc ppc ppc GNU/Linux
>
>Thanks for testing and reporting. This completes the testing of all
>macintosh thermal drivers.
>
>For completeness, as I see you built the driver as a module, could you
>try unloading and reloading it?

Sure:

[jwboyer@localhost macintosh]$ sudo rmmod therm_windtunnel
[jwboyer@localhost macintosh]$ sudo modprobe therm_windtunnel
[jwboyer@localhost macintosh]$ dmesg
<snip>
DS1775 digital thermometer [@49]
Temp: 53.6 C  Hyst: 60.0 C  OS: 65.0 C
ADM1030 fan controller [@2c]
CPU-temp: 53.6 C, Case: 31.8 C,  Fan: 0 (tuned -11)

Seems to work fine.

josh
