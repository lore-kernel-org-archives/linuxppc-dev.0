Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZc9w6QffzDw6h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 13:48:36 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB92hkju113811
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Dec 2016 21:48:33 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 277gu3jxa5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2016 21:48:33 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 9 Dec 2016 12:48:30 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 26FAD2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 13:48:28 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB92mR9d54591696
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 13:48:27 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB92mRGf019878
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 13:48:27 +1100
Subject: Re: [PATCH 3/3] powerpc: enable support for GCC plugins
To: Kees Cook <keescook@chromium.org>, PaX Team <pageexec@freemail.hu>
References: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
 <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
 <5849716A.32374.136DAAC@pageexec.freemail.hu>
 <CAGXu5jKrU5GR3KDb9M-vtSpY+aRm2B0vGpahVYLtFTWs=g7Big@mail.gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Emese Revfy <re.emese@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Brad Spengler <spender@grsecurity.net>, Michal Marek <mmarek@suse.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 9 Dec 2016 13:48:26 +1100
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKrU5GR3KDb9M-vtSpY+aRm2B0vGpahVYLtFTWs=g7Big@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f5ea8825-532c-93bd-d51d-6ec1e541fae6@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/16 05:06, Kees Cook wrote:
>> i don't think that this is the right approach. there's a general and a special
>> issue here, both of which need different handling.
>>
>> the general problem is to detect problems related to gcc plugin headers and
>> notify the users about solutions. emitting various messages from a Makefile
>> is certainly not a scalable approach, just imagine how it will look when the
>> other 30+ archs begin to add their own special cases... if anything, they
>> should be documented in Documentation/gcc-plugins.txt (or a new doc if it
>> grows too big) and the Makefile message should just point at it.

I think I agree in principle - Makefiles are already unreadable enough 
without a million special cases.

>> as for the solutions, the general advice should enable the use of otherwise
>> failing gcc versions instead of forcing updating to new ones (though the
>> latter is advisable for other reasons but not everyone's in the position to
>> do so easily). in my experience all one needs to do is manually install the
>> missing files from the gcc sources (ideally distros would take care of it).

If someone else is willing to write up that advice, then great.

>> the specific problem addressed here can (and IMHO should) be solved in
>> another way: remove the inclusion of the offending headers in gcc-common.h
>> as neither tm.h nor c-common.h are needed by existing plugins. for background,

We can't build without tm.h: http://pastebin.com/W0azfCr0

And we get warnings without c-common.h: http://pastebin.com/Aw8CAj10

>> as for the location of c-common.h, upstream gcc moved it under c-family in
>> 2010 after the release of 4.5, so it should be where gcc-common.h expects
>> it and i'm not sure how it ended up at its old location for you.
>
> That is rather odd. What distro was the PPC test done on? (Or were
> these manually built gcc versions?)

These were all manually built using a script running on a Debian box. 
Installing precompiled distro versions of rather old gccs would have 
been somewhat challenging. I've just rebuilt 4.6.4 to double check that 
I wasn't just seeing things, but it seems that it definitely is still 
putting c-common.h in the old location.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
