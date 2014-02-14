Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1584B2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 08:34:42 +1100 (EST)
Message-ID: <1392413659.10050.14.camel@pasglop>
Subject: Re: [PATCH V2] powerpc: thp: Fix crash on mremap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Sat, 15 Feb 2014 08:34:19 +1100
In-Reply-To: <1392239014.3835.148.camel@pasglop>
References: <1391781117-19045-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140211173129.GB30336@kroah.com> <87ioslt54d.fsf@linux.vnet.ibm.com>
 <20140212142334.GB7688@kroah.com> <1392239014.3835.148.camel@pasglop>
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

On Thu, 2014-02-13 at 08:03 +1100, Benjamin Herrenschmidt wrote:

> It looks very different because the function that needs to be fixed
> changed a lot upstream in 3.13.

 .../...

Hi Greg !

You didn't say if that explanation was to your liking :-)

If it is, do you want Aneesh to re-submit the patch with such an
explanation in the changelog ?

Cheers,
Ben.

> In practice it's *not* very different in behaviour. It's just that
> on powerpc we need to unconditionally call withdraw and deposit when
> moving PTEs or it will crash, due to how we keep the transparent
> huge page in sync with the hash table.
> 
> With the 3.13 code, due to lock breaking introduced by Kirill in
> 3.13-rc's, there's already a generic case for doing that (if we dropped
> the lock). So we just changed the condition to essentially force the
> condition to true to always do it under control of an arch helper.
> 
> The pre-3.13 code didn't do the withdraw and deposit at all in that
> function however, so in that case, the patch (this 3.12 one) basically
> just adds the calls to withdraw and deposit under control of an ifdef
> which is only enabled for powerpc64.
> 
> So you are taking 0 risk with other architecture and as the powerpc
> maintainer I'm happy with the patch.
> 
> Cheers,
> Ben.
> 
> 
