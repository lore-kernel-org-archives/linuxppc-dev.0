Return-Path: <dan@embeddededge.com>
In-Reply-To: <6d145b4205072809505b101b48@mail.gmail.com>
References: <6d145b4205072809505b101b48@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5367eda3a78096bb46168292371e9530@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 28 Jul 2005 14:06:04 -0400
To: Prashant Alange <prashant.alange@gmail.com>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Problem allocating large meory using m8260_cpm_hostalloc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 28, 2005, at 12:50 PM, Prashant Alange wrote:

> Could anyone tell what I am missing here?

You are not supposed to be using this function for such memory
allocations.

> How can I allocate large memory in my driver using this hostalloc 
> function?

You don't.  If you look at the existing drivers and comments, you'll 
see it's
intended to only allocate small objects that are too inefficient to 
manage
with the usual Linux DMA allocation functions.  You must use the 
standard
Linux DMA for large allocations.  Read Documentation/DMA-API.txt, and
in particular the non-PCI functions.

Thanks.


	-- Dan
