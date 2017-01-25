Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7WQv5DnRzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 14:55:03 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 194so18383945pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 19:55:03 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 25 Jan 2017 09:24:53 +0530
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 Jan Stancek <jstancek@redhat.com>, Herton Krzesinski <hkrzesin@redhat.com>,
 Artem Savkov <asavkov@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [bug] stack protector panics on v4.10-rc1+
Message-ID: <20170125035453.GA12855@localhost.localdomain>
References: <627000186.495731.1485210132000.JavaMail.zimbra@redhat.com>
 <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
 <20170124010421.GI30284@gate.crashing.org>
 <8737g9azuj.fsf@concordia.ellerman.id.au>
 <87ziih9jzv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ziih9jzv.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 24, 2017 at 03:09:40PM +1100, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > # zgrep STACKPROTECTOR /proc/config.gz 
> > CONFIG_HAVE_CC_STACKPROTECTOR=y
> > CONFIG_CC_STACKPROTECTOR=y
> > CONFIG_CC_STACKPROTECTOR_REGULAR=y
> >
> > I guess I'm just lucky?
> 
> No, I'm just using a gcc built without libc as Segher pointed out:
> 
>   https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg113181.html
> 
>   Right.  Tony's compilers are built using a (modified version of) buildall,
>   and buildall goes out of its way to build without libc whatsoever, even
>   if the configuration (powerpc64-linux, for example) expects one.
>   
>   Which leads to TARGET_LIBC_PROVIDES_SSP being undefined (it would normally
>   be true for glibc >= 2.4), and that is all.  Mystery solved.  Thanks!
> 
> 
> So my inclination is to revert the powerpc stack protector code for
> 4.10, and we can try again for 4.11 or 12.
>

That makes sense. We then wait for the right gcc version? I guess we also
push for per-task gaurd value as opposed to a global one?

Balbir Singh 
