Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYSHy20d0zDvj3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 16:49:50 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB75mcjg080713
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:49:48 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2763yc660b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 00:49:48 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 7 Dec 2016 15:49:45 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9670C357805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 16:49:42 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB75ngaL1311138
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 16:49:42 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB75nfTx020636
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 16:49:42 +1100
Subject: Re: [PATCH 3/3] powerpc: enable support for GCC plugins
To: Emese Revfy <re.emese@gmail.com>
References: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
 <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
 <20161206222520.7fb37896488eff1b299eb3db@gmail.com>
Cc: spender@grsecurity.net, keescook@chromium.org,
 linux-kbuild@vger.kernel.org, kernel-hardening@lists.openwall.com,
 linux-kernel@vger.kernel.org, mmarek@suse.com, pageexec@freemail.hu,
 linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 7 Dec 2016 16:49:41 +1100
MIME-Version: 1.0
In-Reply-To: <20161206222520.7fb37896488eff1b299eb3db@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f32f62b8-dc38-6f0b-e7b7-1f85e504df5d@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/16 08:25, Emese Revfy wrote:
> What are these missing headers? Because if they aren't necessary then they can
> be removed from gcc-common.h. There were missing headers on arm/arm64 and these
> archs are supported. I think this version check is unnecessary because
> gcc-plugin.sh also checks the missing headers.

rs6000-cpus.def, included via tm.h - see 
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66840

I realise gcc-plugin.sh does detect this, but the point of the 
additional version check is to provide somewhat more helpful advice to 
the user.

> What is the problem on gcc-4.5/gcc-4.6?

On 4.6.4, c-family/c-common.h:

/scratch/ajd/gcc-test-v2/kernel/scripts/gcc-plugins/gcc-common.h:60:31: 
fatal error: c-family/c-common.h: No such file or directory

ajd@ka1:/scratch/ajd/tmp/cross/gcc-4.6.4-nolibc/powerpc64-linux$ find 
-name c-common.*
./lib/gcc/powerpc64-linux/4.6.4/plugin/include/c-common.h
./lib/gcc/powerpc64-linux/4.6.4/plugin/include/c-family/c-common.def

Are we sure the version check in gcc-common.h:59 is correct, or is this 
just a peculiarity of my particular toolchain?

I need to build another 4.5 toolchain, I'll try to do that this week.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
