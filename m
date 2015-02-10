Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4B411A0B95
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:59:04 +1100 (AEDT)
Message-ID: <1423540744.19657.12.camel@ellerman.id.au>
Subject: Re: [PATCH 00/18] sync opal.h with firmware
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 14:59:04 +1100
In-Reply-To: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 13:26 +1100, Stewart Smith wrote:
> This patch series takes a careful step-by-step process to sync the
> opal.h header file (definition of interface to OPAL firmware) with
> opal.h in firmware.
> 
> Each patch is designed to be as obvious as possible so that it's
> easy for someone else to prove that I haven't messed it up anywhere.
> 
> In the process of doing this, I fixed a few things in firmware too,
> so this matches skiboot at 4681ed9, which is a little after the most
> recent skiboot release (4.1.1).
> 
> The biggest change is moving the function prototypes for API calls
> out to opal-api.h.

Hi Stewart,

I'm going to be a total pain, and suggest that this is the wrong approach :)

I was on board until patch 15, where you have to add an #ifdef SKIBOOT to guard
an include, and you have to remove an include on the Linux side.

I think the better solution would be to pull all the common parts out into a
new file, opal-api.h. That file would define the API between Linux & Skiboot,
and absolutely nothing else.

Both Linux and Skiboot would continue to have an opal.h, which would include
opal-api.h, and then anything else needed on either side to make a functioning
opal.h - eg. other includes & definitions (SG_ENTRIES_PER_NODE).

It would also have the advantage that because opal-api.h is a new file, we can
get it synced from the beginning and not worry about all the whitespace &
rearranging patches. ie. there'd just be one patch on both sides to add the new
file and move definitions into it from opal.h.

If you don't violently disagree I'll do a patch for that and we can see how it
looks?

cheers
