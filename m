Return-Path: <benjamin.zores@alcatel-lucent.fr>
Received: from smail6.alcatel.fr (smail6.alcatel.fr [62.23.212.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smail.alcatel.fr", Issuer "smail.alcatel.fr" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A15E7DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 00:35:41 +1000 (EST)
Received: from bsf.alcatel.fr (mail205.sxb.bsf.alcatel.fr [155.132.205.115])
	by smail6.alcatel.fr (8.13.8/8.13.8/ICT) with ESMTP id n44ERs2g001503
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 16:27:54 +0200
Received: from mail (mail-bsf-alcatel-fr.sxb.bsf.alcatel.fr [155.132.205.91])
	by bsf.alcatel.fr (8.8.8p2+Sun/8.9.3) with ESMTP id QAA03611
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 16:27:53 +0200 (MET DST)
Received: from [172.25.51.39] (frilln0l014001.emea.lucent.com [172.25.51.39])
	by mail (8.8.8p2+Sun/) with ESMTP id QAA03603
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 16:27:53 +0200 (MET DST)
Message-ID: <49FEFB69.4040208@alcatel-lucent.fr>
Date: Mon, 04 May 2009 16:27:53 +0200
From: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: FSL Driver load issues with OF
References: <49F821B0.6030706@alcatel-lucent.fr>
	<20090430162019.GA3655@ld0162-tx32.am.freescale.net>
In-Reply-To: <20090430162019.GA3655@ld0162-tx32.am.freescale.net>
Content-Type: multipart/alternative;
	boundary="------------030100040309020302030107"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030100040309020302030107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Scott Wood wrote:
> On Wed, Apr 29, 2009 at 11:45:20AM +0200, Benjamin Zores wrote:
>   
>> Since the progressive migration of some PPC drivers to use of_platform bus
>> (typically migrating OF parsing from fsl_soc.c to the device probe/init 
>> functions),
>> I'm experiencing driver load issues.
>>
>> Actually, I'm not longer able to load of these drivers as the probe() 
>> function is never called.
>>     
>
> Make sure your board is calling of_platform_bus_probe(), and that the
> devices you're trying to probe are under buses described by the id list.
>   
Thx for spotting this point.
When porting my custom board I indeed had a part of code that returned 
before of_platform_bus_probe()
can be called. Thx again, it now works fine.

Ben

--------------030100040309020302030107
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Scott Wood wrote:
<blockquote
 cite="mid:20090430162019.GA3655@ld0162-tx32.am.freescale.net"
 type="cite">
  <pre wrap="">On Wed, Apr 29, 2009 at 11:45:20AM +0200, Benjamin Zores wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Since the progressive migration of some PPC drivers to use of_platform bus
(typically migrating OF parsing from fsl_soc.c to the device probe/init 
functions),
I'm experiencing driver load issues.

Actually, I'm not longer able to load of these drivers as the probe() 
function is never called.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Make sure your board is calling of_platform_bus_probe(), and that the
devices you're trying to probe are under buses described by the id list.
  </pre>
</blockquote>
Thx for spotting this point.<br>
When porting my custom board I indeed had a part of code that returned
before of_platform_bus_probe()<br>
can be called. Thx again, it now works fine.<br>
<br>
Ben<br>
</body>
</html>

--------------030100040309020302030107--
