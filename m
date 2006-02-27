Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC9CD67A01
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 03:12:59 +1100 (EST)
In-Reply-To: <1140986335.8697.139.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org>
	<1140986335.8697.139.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <77448EF2-4D5F-4E7C-B1A5-6164A88E43C7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for
	!MULTIPLATFORM
Date: Mon, 27 Feb 2006 10:12:44 -0600
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 26, 2006, at 2:38 PM, Dave Hansen wrote:

> On Fri, 2006-02-24 at 10:54 -0600, Kumar Gala wrote:
>> +       if (strstr(cmd_line, "mem=")) {
>> +               char *p, *q;
>> +               unsigned long maxmem = 0;
>> +
>> +               for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
>> +                       q = p + 4;
>> +                       if (p > cmd_line && p[-1] != ' ')
>> +                               continue;
>> +                       maxmem = simple_strtoul(q, &q, 0);
>> +                       if (*q == 'k' || *q == 'K') {
>> +                               maxmem <<= 10;
>> +                               ++q;
>> +                       } else if (*q == 'm' || *q == 'M') {
>> +                               maxmem <<= 20;
>> +                               ++q;
>> +                       } else if (*q == 'g' || *q == 'G') {
>> +                               maxmem <<= 30;
>> +                               ++q;
>> +                       }
>> +               }
>> +               memory_limit = maxmem;
>> +       }
>
> You may want to check out lib/cmdline.c's memparse() function.  I  
> think
> it does this for you.

Yeah, found it after I sent the patch.  Since Linus applied this  
version, I'll provide Paul a version that changes this code to use  
memparse for post 2.6.16.

- kumar
