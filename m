Return-Path: <david.vrabel@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DEDDE2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 21:58:50 +1100 (EST)
Message-ID: <52D7B8C8.9010301@citrix.com>
Date: Thu, 16 Jan 2014 10:47:36 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2] drivers/tty/hvc: don't use module_init in non-modular
 hyp. console code
References: <1389821743-25081-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1389821743-25081-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/01/14 21:35, Paul Gortmaker wrote:
> The HVC_OPAL/RTAS/UDBG/XEN options are all bool, and hence their support
> is either present or absent.  It will never be modular, so using
> module_init as an alias for __initcall is rather misleading.
> 
> Fix this up now, so that we can relocate module_init from
> init.h into module.h in the future.  If we don't do this, we'd
> have to add module.h to obviously non-modular code, and that
> would be a worse thing.
> 
> Note that direct use of __initcall is discouraged, vs. one
> of the priority categorized subgroups.  As __initcall gets
> mapped onto device_initcall, our use of device_initcall
> directly in this change means that the runtime impact is
> zero -- it will remain at level 6 in initcall ordering.
> 
> Also the __exitcall functions have been outright deleted since
> they are only ever of interest to UML, and UML will never be
> using any of this code.

For the hvc_xen changes

Acked-by: David Vrabel <david.vrabel@citrix.com>

Thanks

David
