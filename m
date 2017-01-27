Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8nzJ4r6JzDq98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 16:54:03 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0R5s1aq064125
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 00:54:01 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 287w54drsn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 00:54:00 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 27 Jan 2017 15:53:53 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A4A442CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 16:53:51 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0R5rhbq35389520
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 16:53:51 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0R5rIK6024334
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 16:53:19 +1100
Subject: Re: [PATCH 3/3] powerpc: enable support for GCC plugins
To: pageexec@freemail.hu, Kees Cook <keescook@chromium.org>
References: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
 <CAGXu5jKrU5GR3KDb9M-vtSpY+aRm2B0vGpahVYLtFTWs=g7Big@mail.gmail.com>
 <f5ea8825-532c-93bd-d51d-6ec1e541fae6@au1.ibm.com>
 <584A8E9E.22035.590FC72@pageexec.freemail.hu>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Emese Revfy <re.emese@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Brad Spengler <spender@grsecurity.net>, Michal Marek <mmarek@suse.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 27 Jan 2017 16:52:54 +1100
MIME-Version: 1.0
In-Reply-To: <584A8E9E.22035.590FC72@pageexec.freemail.hu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <25e3a510-1652-5be9-cc26-24d35f9ac95e@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/16 21:59, PaX Team wrote:
>>>> the specific problem addressed here can (and IMHO should) be solved in
>>>> another way: remove the inclusion of the offending headers in gcc-common.h
>>>> as neither tm.h nor c-common.h are needed by existing plugins. for background,
>>
>> We can't build without tm.h: http://pastebin.com/W0azfCr0
>
> you'll need to repeat the removal of dependent headers. based on a quick
> test here across gcc 4.5-6.2, if you remove rtl.h, tm_p.h, hard-reg-set.h
> and emit-rtl.h in addition to tm.h, the plugins should build fine.

OK, I finally have a chance to look at this series again.

basic-block.h includes tm.h, and I don't believe we can remove that. I'm 
not convinced there's a way around this.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
