Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id C3E86DDFF9
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 04:45:45 +1000 (EST)
Received: from [192.168.1.37] (node146.76.251.72.1dial.com [72.251.76.146])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m56IheX5046361
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 11:45:36 -0700 (PDT)
Message-ID: <48498550.7040004@hypersurf.com>
Date: Fri, 06 Jun 2008 11:43:28 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 750GX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

	In the 750GX data sheet (750GX_ds2-17-05.pdf), page 45 has Table 5-1 
that describes the PLL range field. It goes something like this:

	PLL_RNG	   range
	  00	600 - 900
	  01	900 - 1000
	  10	500 - 600

Anyone have any thoughts as to what the correct values are for 600 and 900?

	I think I have this working. I was setting the range to 1 for all 
frequencies because I did:

	if(freq<600)

instead of

	if(freq<600000)

when building my frequency table.

	This cpufreq stuff definitely messes up the repeatability of my 
bogomazes value.

kevin

P.S.:  I'd be interested in various theories as to what this does?

P.P.S.:  On page 341 of the 750GX user manual It says:

	"Turning the non selected PLL off results in a modest power savings ..."

	Regarding what goes on in idle_6xx.S, wouldn't this likely save more 
power than switching to a lower frequency (to clock mostly nothing since 
the processor is going into doze or nap)?
