Return-Path: <sshtylyov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id BE709DDF1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 00:13:12 +1000 (EST)
Message-ID: <461B9BA7.1070304@ru.mvista.com>
Date: Tue, 10 Apr 2007 18:13:59 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: "Benedict, Michael" <MBenedict@twacs.com>
Subject: Re: MPC 8349e-mITX and MTD/Flash
References: <CF7E46FCFF66AD478BB72724345289EC2795D1@twx-exch01.twacs.local>	<572211.38645.qm@web306.biz.mail.mud.yahoo.com>
	<CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Benedict, Michael wrote:
> Ben,
> 	I assume that you intended to CC the list but accidently hit
> "reply" instead.  If not, I apologize.  Thank you for all your help so
> far.

>>-----Original Message-----
>>From: Ben Warren [mailto:bwarren@qstreams.com] 
>>Sent: Monday, April 09, 2007 4:30 PM
>>To: Benedict, Michael
>>Subject: Re: MPC 8349e-mITX and MTD/Flash

>>I suspect that MTD doesn't know anything about how
>>your flash chip is organized.  Probably the easiest
>>thing to use is CONFIG_MTD_PHYSMAP.  Using this, you
>>can either pass the MTD partitioning info via kernel
>>command line, via static physmap structures in your
>>board code or, I believe, via device tree (I haven't
>>tried the last one).

> The following is from my .config
> <snip>
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_START=0x8000000
> CONFIG_MTD_PHYSMAP_LEN=0x0
> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> # CONFIG_MTD_PHYSMAP_OF is not set
> CONFIG_MTD_PLATRAM=y
> <snip>
> 
> Is this what you are referring to?  Does something look obviously wrong
> with it?

    Yeah, CONFIG_MTD_PHYSMAP_LEN shoudn't be 0 unless you're registering your 
MTD via the platform device mechanism (and in that case specifying 
CONFIG_MTD_PHYSMAP_START and CONFIG_MTD_PHYSMAP_BANKWIDTH doesn't make sense).

WBR, Sergei
