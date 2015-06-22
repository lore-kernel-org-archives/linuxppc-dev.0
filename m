Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A0991A0F69
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 05:41:18 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A592914010F
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 05:41:15 +1000 (AEST)
Date: Mon, 22 Jun 2015 14:35:55 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, thuth@redhat.com, aik@ozlabs.ru, dvaleev@suse.com
Subject: Re: [PATCH SLOF 3/5] disk-label: introduce helper to check fat
 filesystem
Message-ID: <20150622193555.GD19845@gate.crashing.org>
References: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1434959987-8530-4-git-send-email-nikunj@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434959987-8530-4-git-send-email-nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 22, 2015 at 01:29:45PM +0530, Nikunj A Dadhania wrote:
> +: has-fat-filesystem ( block -- true | false )
> +   \ block 0 byte 0-2 is a jump instruction in all FAT
> +   \ filesystems.

"block" there is not a block number, just a host address.  So it's not
a good name.  Maybe do a better name for this word as well, something
saying it looks at a disk block.

> +   \ e9 and eb are jump instructions in x86 assembler.
> +   dup c@ e9 <> IF
> +      dup c@ eb <> swap
> +      2+  c@ 90 <> or
> +      IF false EXIT THEN
> +   ELSE DROP THEN
> +   TRUE
> +;

Don't write DROP and TRUE in caps please.  The purpose of having the
structure words in caps is to make them stand out more, to make things
more readable; putting other things in caps as well destroys that.

Since you factored this, it becomes more readable if you invert the
conditions:

: fat-bootblock? ( addr -- flag )
   \ byte 0-2 of the bootblock is a jump instruction in
   \ all FAT filesystems.
   \ e9 and eb are jump instructions in x86 assembler.
   dup c@ e9 = IF drop true EXIT THEN
   dup c@ eb = swap 2+ c@ 90 = and ;

(not tested, etc.)


Segher
