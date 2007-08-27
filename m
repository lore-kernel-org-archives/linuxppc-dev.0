Return-Path: <anton@ozlabs.org>
Date: Mon, 27 Aug 2007 15:31:57 -0500
From: Anton Blanchard <anton@samba.org>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: what is ~1MB of memory allocated at fffea000-fffff000 on ppc64?
Message-ID: <20070827203157.GD13612@kryten>
References: <46D3326C.3000505@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46D3326C.3000505@nortel.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> I've got a ppc64 box running 2.6.14.  64-bit kernel, 32-bit userspace. 
> It has a ~86KB chunk of memory near the top of the process address 
> space, and I'm not sure who's setting it up and what the purpose is.  In 
> /proc/<pid>/maps it looks like this:
> 
> fffea000-fffff000 rw-p fffea000 00:00 0
> 
> Can anyone enlighten me as to what this is for and who is allocating it?

Looks like your process stack. BTW we leave the top page
(0xfffff000 - 0xffffffff) unmapped mostly because of test cases that
expect

*(unsigned long *)-1UL

to fail.

Anton
