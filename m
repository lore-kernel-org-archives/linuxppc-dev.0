Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CBBD2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 19:49:45 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 5 Dec 2013 08:49:41 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0849317D8067
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 08:49:30 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB58mAGq46596284
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 08:48:10 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB58mMag015817
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 01:48:22 -0700
Message-ID: <52A03E4F.6090304@linux.vnet.ibm.com>
Date: Thu, 05 Dec 2013 09:50:23 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix xmon disassembler for little-endian
References: <1385975412-25869-1-git-send-email-felix@linux.vnet.ibm.com>
 <529C9397.9050704@gmail.com> <529F31F8.6040302@linux.vnet.ibm.com>
 <1386218366.21910.16.camel@pasglop>
In-Reply-To: <1386218366.21910.16.camel@pasglop>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Tom Musta <tommusta@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2013-12-04 at 14:45 +0100, Philippe Bergheaud wrote:
> 
> 
>>>>+#ifdef __LITTLE_ENDIAN__
>>>>+#define GETWORD(v)	(((v)[3] << 24) + ((v)[2] << 16) + ((v)[1] << 8) + (v)[0])
>>>>+#else
>>>>#define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
>>>>+#endif
>>>>
>>>>#define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
>>>>			 || ('a' <= (c) && (c) <= 'f') \
>>>>
>>>
>>>
>>>Philippe:  Wouldn't it be better to just do a 32-bit load and let the endianness be worked out
>>>by the hardware?  i.e.
>>>
>>>#define GETWORD(v) (*(u32 *)v)
>>
>>Yes, your alternative is better.
>>Wouldn't it narrow the scope of the macro to aligned words on POWER7?
>>I think that all references to GETWORD operate on aligned words anyway.
> 
> 
> Well, xmon has to be robust ... as long as you are *certain* that even
> with crap entry state it won't try to access unaligned boundaries then
> go for it but we aren't looking at performance here.
Thank you Tom and Ben.  We are definitely not looking at performance here.
I prefer to stay on the safe side, and leave the original patch untouched.

Philippe
