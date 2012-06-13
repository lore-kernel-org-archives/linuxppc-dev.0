Return-Path: <geoff@infradead.org>
Message-ID: <1339610324.3986.6.camel@clam>
Subject: Re: [Cbe-oss-dev] [PATCH 05/10] powerpc/ps3: Use highmem region
 from repository
From: Geoff Levand <geoff@infradead.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 13 Jun 2012 10:58:44 -0700
In-Reply-To: <1339552163.25512.2.camel@concordia>
References: <cover.1335379330.git.geoff@infradead.org>
 <1e755c09926de2d9b0e239ba0ce10fdb6835551a.1335379330.git.geoff@infradead.org>
 <1339552163.25512.2.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 Hector Martin <hector@marcansoft.com>,
 Nathan Whitehorn <nwhitehorn@freebsd.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wed, 2012-06-13 at 11:49 +1000, Michael Ellerman wrote:
> On Wed, 2012-04-25 at 19:19 +0000, Andre Heider wrote:
> > Use any preallocated highmem region setup by the bootloader.
> > This implementation only checks for the existance of a single
> > region at region_index=0.
> > 
> > This feature allows the bootloader to preallocate highmem
> > regions and pass the region locations to the kernel through
> > the repository.  Preallocated regions can be used to hold the
> > initrd or other large data.  If no region info exists, the
> > kernel retains the old behavior and attempts to allocate the
> > highmem region itself.
> > 
> > Based on Hector Martin's patch "Get lv1 high memory region from
> > devtree".
> 
> Apologies if this has been covered before, but why not use the device
> tree?

FreeBSD (and other OS's) don't know about the Linux device tree.

This mechanism is for the bootloader to tell the OS about a highmem
region it setup, and we want to support more than just Linux.

-Geoff
