Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1FACF2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 15:13:44 +1100 (EST)
Message-ID: <1352866404.23412.17.camel@pasglop>
Subject: Re: HVC console breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Wed, 14 Nov 2012 15:13:24 +1100
In-Reply-To: <20121114135702.7b332dd7@kryten>
References: <20121114135702.7b332dd7@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, gregkh@linuxfoundation.org,
 Paul Mackerras <paulus@au1.ibm.com>, jslaby@suse.cz, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-11-14 at 13:57 +1100, Anton Blanchard wrote:
> Hi,
> 
> Commit bdb498c20040 (TTY: hvc_console, add tty install) breaks HVC on
> ppc64. It looks a bit like a refcounting issue and we end up releasing
> the tty. I haven't had a change to look closer yet.

Adding Paulus who is looking into it. So far what we observe is that
something (possibly a close() on a hvc tty by userspace) causes the port
to be destroyed permanently. Typically hits with fedora 17.

Cheers,
Ben.
