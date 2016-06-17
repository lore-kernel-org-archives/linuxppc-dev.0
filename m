Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW6865H77zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 14:04:22 +1000 (AEST)
Date: Thu, 16 Jun 2016 23:04:12 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Chris Smart <chris@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [Patch v2 1/2] powerpc: Send SIGBUS on unaligned copy and paste
Message-ID: <20160617040412.GC25170@gate.crashing.org>
References: <20160616233340.GA14449@distroguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160616233340.GA14449@distroguy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2016 at 09:33:45AM +1000, Chris Smart wrote:
> +#define PPC_INST_COPY			0x7c00060c
> +#define PPC_INST_COPY_FIRST		0x7c20060c

> +#define PPC_INST_PASTE			0x7c00070c
> +#define PPC_INST_PASTE_LAST		0x7c20070d

That's not quite right I think.

copy is       7c00060c mask fc2007fe (or ffe007fe)
copy_first is 7c20060c mask fc2007fe
paste is      7c00070c mask fc2007fe
paste_last is 7c20070c mask fc2007fe

(this includes record form for paste; the low bit).


Segher
