Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 20DFBB6FB1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 May 2011 03:27:31 +1000 (EST)
Date: Mon, 23 May 2011 10:27:27 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: PCI DMA to user mem on mpc83xx
Message-ID: <20110523172727.GA21717@ovro.caltech.edu>
References: <4DDA2509.6070702@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DDA2509.6070702@matrix-vision.de>
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2011 at 11:12:41AM +0200, Andre Schwarz wrote:
> Ira,
> 
> we have a pretty old PCI device driver here that needs some basic rework 
> running on 2.6.27 on several MPC83xx.
> It's a simple char-device with "give me some data" implemented using 
> read() resulting in zero-copy DMA to user mem.
> 
> There's get_user_pages() working under the hood along with 
> SetPageDirty() and page_cache_release().
> 
> Main goal is to prepare a sg-list that gets fed into a DMA controller.
> 
> I wonder if there's a more up-to-date/efficient and future proof scheme 
> of creating the mapping.
> 
> 
> Could you provide some pointers or would you stick to the current scheme ?
> 

This scheme is the best you'll come up with for zero-copy IO. I used
get_user_pages_fast(), but otherwise my implementation was the same.
These interfaces should be fairly future proof.

In the end, I realized that most of my transfers were 4 bytes in length,
and zero copy IO was a waste of effort. I decided to use mmap instead.

Ira
