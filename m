Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9896C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Feb 2022 21:00:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JpvMm0gyjz3dqb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Feb 2022 08:00:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=neutral (access neither permitted nor denied)
 smtp.mailfrom=codon.org.uk (client-ip=2a00:1098:84:22e::2;
 helo=cavan.codon.org.uk; envelope-from=mjg59@codon.org.uk; receiver=<UNKNOWN>)
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jpb3j6KCwz30Lt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Feb 2022 19:45:37 +1100 (AEDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
 id 8C04C40A51; Wed,  2 Feb 2022 08:45:34 +0000 (GMT)
Date: Wed, 2 Feb 2022 08:45:34 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <20220202084534.GA10247@srcf.ucam.org>
References: <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
 <20220202040157.GA8019@srcf.ucam.org> <YfogOurPZb7+Yelo@kroah.com>
 <20220202065443.GA9249@srcf.ucam.org> <YfotMyQiQ66xfCOQ@kroah.com>
 <20220202071023.GA9489@srcf.ucam.org>
 <CAMj1kXFTyc9KnMsnvs+mt80DbJL8VGKKcQ0J=4NrGYGSAG8sRw@mail.gmail.com>
 <20220202080401.GA9861@srcf.ucam.org>
 <20220202083653.p3cb4w3qdud4e33t@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202083653.p3cb4w3qdud4e33t@sirius.home.kraxel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Thu, 03 Feb 2022 07:58:06 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>, Lenny Szubowicz <lszubowi@redhat.com>,
 gcwilson@linux.ibm.com, Ard Biesheuvel <ardb@kernel.org>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>,
 Nayna Jain <nayna@linux.ibm.com>, James Morris <jmorris@namei.org>,
 Dov Murik <dovmurik@linux.ibm.com>, Jim Cadden <jcadden@ibm.com>,
 Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, dougmill@linux.vnet.ibm.com,
 James Bottomley <jejb@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@linux.ibm.com>, linux-coco@lists.linux.dev,
 gjoyce@ibm.com, Daniel Axtens <dja@axtens.net>,
 Dave Hansen <dave.hansen@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org,
 "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, Andrew Scull <ascull@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 02, 2022 at 09:36:53AM +0100, Gerd Hoffmann wrote:

> Having a "secrets/" directory looks good to me.  Then the individual
> implementations can either add files to the directory, i.e. efi_secrets
> would create "secrets/<guid>" files.  Or each implementation creates a
> subdirectory with the secrets, i.e. "secrets/coco/" and
> "secrets/coco/<guid>".

I prefer a subdirectory, on the basis that we could conceivably end up 
with more than one implementation on a single device at some point, and 
also because it makes it trivial for userland to determine what the 
source is which may make a semantic difference under certain 
circumstances.
 
> Longer-term (i.e once we have more than one implementation) we probably
> need a separate module which owns and manages the "secrets/" directory,
> and possibly provides some common helper functions too.

Agree.
