Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 3E77767FBD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 03:26:20 +1000 (EST)
Message-ID: <430A0AB9.20000@icarus.com>
Date: Mon, 22 Aug 2005 10:26:17 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <4309E2AC.9080404@icarus.com>
	<20d4aca8d8032c5762deb047185d2c6e@embeddededge.com>
In-Reply-To: <20d4aca8d8032c5762deb047185d2c6e@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mmap nocache on PPC, 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dan Malek wrote:
|
| On Aug 22, 2005, at 10:35 AM, Stephen Williams wrote:
|
|> In an embedded system, I want a big chunk of virtual memory in the
|> user process to be uncached.
|
|
| Why?  What processor it this?  Who else touches this memory?

PPC405GPr. The only things touching the memory are a PCI compressor
chip that is writing the buffer, a user mode thread that is putting
some image headers around it, and another device that reads it out.
I believe that if the memory is mapped uncached in the user mode
process then I'm safe.


|> .... I've created a virtual device driver that
|> has this mmap method:
|
|
| Even if this did what you thought it should, I'm not sure you
| would be happy with the results.  The challenge is ensuring
| anyone that touches these physical pages also does so
| uncached.  Depending upon the processor, this isn't something
| that is trivial to change in the kernel, since we always map
| all of memory as efficiently as possible with a cached mapping.
| The caching of memory has many desirable performance
| side effects, making the trade off the manage coherency in
| software if needed an overall system gain.

The processor is touching this memory only very briefly to put
image headers around the data, and even at that it would need
to be immediately flushed again so that it can be DMAed off the
system.

My problem is that I need a lot of memory that is mostly accessed
by high performance devices that make lots of data, and only
very occasionally accessed by the processor for minor fixups.
Caching is very much getting in my way here in this specialized
case, I think.

- --
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDCgq4rPt1Sc2b3ikRApqMAJ9IuHhK6mi92ysju18xyQJsKNG4qQCff9aV
4sTZ0uRyuPmNW+FQYJYfS10=
=z2iH
-----END PGP SIGNATURE-----
