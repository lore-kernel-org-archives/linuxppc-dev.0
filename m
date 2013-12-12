Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1F6762C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 06:34:08 +1100 (EST)
Message-ID: <1386876830.1002.4.camel@smoke>
Subject: Re: [PATCH 2/4] kexec: Add IND_FLAGS macro
From: Geoff Levand <geoff@infradead.org>
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Date: Thu, 12 Dec 2013 11:33:50 -0800
In-Reply-To: <52A912E3.1060802@cn.fujitsu.com>
References: <cover.1386807069.git.geoff@infradead.org>
 <3d9d024551c3c0e560d77f81926cb5774dda7067.1386807069.git.geoff@infradead.org>
 <52A912E3.1060802@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 Eric Biederman <ebiederm@xmission.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Zhang,

On Thu, 2013-12-12 at 09:35 +0800, Zhang Yanfei wrote:
> On 12/12/2013 08:18 AM, Geoff Levand wrote:
> > Add a new kexec preprocessor macro IND_FLAGS, which is the bitwise OR of
> > all the possible kexec IND_ kimage_entry indirection flags.
> > 
> > Having this macro allows for simplified code in the prosessing of the
> > kexec kimage_entry items.
> 
> Where? I didn't see any place you use this macro to help simplification.

As in powerpc, it allows constructions like this:

  switch (entry & IND_FLAGS) {
  case IND_DESTINATION:
  ...
  case IND_INDIRECTION:
  ...
  }

-Geoff
