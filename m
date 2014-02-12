Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AFC8E2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 08:03:53 +1100 (EST)
Message-ID: <1392239014.3835.148.camel@pasglop>
Subject: Re: [PATCH V2] powerpc: thp: Fix crash on mremap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 13 Feb 2014 08:03:34 +1100
In-Reply-To: <20140212142334.GB7688@kroah.com>
References: <1391781117-19045-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140211173129.GB30336@kroah.com> <87ioslt54d.fsf@linux.vnet.ibm.com>
 <20140212142334.GB7688@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-02-12 at 06:23 -0800, Greg KH wrote:
> I have no idea what that means...
> 
> If you want this patch applied, please be specific as to what is going
> on, why the code is _very_ different, and all of that.  Make it
> _obvious_ as to what is happening, and why I would be a fool not to
> take
> it in the stable tree.
> 
> As it is, the code in this patch looks so different that I'm just
> assuming you got something wrong and are trying to really send me
> something else, so I'll just ignore it.

It looks very different because the function that needs to be fixed
changed a lot upstream in 3.13.

In practice it's *not* very different in behaviour. It's just that
on powerpc we need to unconditionally call withdraw and deposit when
moving PTEs or it will crash, due to how we keep the transparent
huge page in sync with the hash table.

With the 3.13 code, due to lock breaking introduced by Kirill in
3.13-rc's, there's already a generic case for doing that (if we dropped
the lock). So we just changed the condition to essentially force the
condition to true to always do it under control of an arch helper.

The pre-3.13 code didn't do the withdraw and deposit at all in that
function however, so in that case, the patch (this 3.12 one) basically
just adds the calls to withdraw and deposit under control of an ifdef
which is only enabled for powerpc64.

So you are taking 0 risk with other architecture and as the powerpc
maintainer I'm happy with the patch.

Cheers,
Ben.
