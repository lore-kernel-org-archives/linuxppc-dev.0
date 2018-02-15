Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhnZT5Y3BzF11s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 18:14:03 +1100 (AEDT)
Date: Thu, 15 Feb 2018 08:13:58 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call
 setup_rfi_flush() again
Message-ID: <20180215081358.2f37cda4@naga.suse.cz>
In-Reply-To: <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, 14 Feb 2018 19:33:40 -0200
Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> wrote:

> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> For PowerVM migration we want to be able to call setup_rfi_flush()
> again after we've migrated the partition.
> 
> To support that we need to check that we're not trying to allocate the
> fallback flush area after memblock has gone away. If so we just fail,
> we don't support migrating from a patched to an unpatched machine. Or
> we do support it, but there will be no RFI flush enabled on the
> destination.
> 

This sounds bad to me. Either we support RFI flush or we don't.

If we do the fallback area should be allocated at boot so it is always
available. The user can use nopti to disable all RFI flush and then it
is OK to not allocate it.

Thanks

Michal
