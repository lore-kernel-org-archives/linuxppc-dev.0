Return-Path: <flar@cynthia.pants.nu>
Date: Sun, 30 Dec 2007 15:43:32 -0800
From: Brad Boyer <flar@allandria.com>
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: Device node - How does kernel know about it
Message-ID: <20071230234332.GC2203@cynthia.pants.nu>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7012AF958@corpexc01.corp.networkrobots.com>
	<Pine.LNX.4.60.0712280936420.1827@rtl14.hofr.at>
	<D83235F0F3C86D4D889D8B9A0DA8C6D7012AFA2D@corpexc01.corp.networkrobots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7012AFA2D@corpexc01.corp.networkrobots.com>
Cc: linuxppc-dev@ozlabs.org, Nicholas Mc Guire <der.herr@hofr.at>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 27, 2007 at 07:27:17PM -0800, Siva Prasad wrote:
> What is the kernel routine that is first called when there is, for
> example a read() function call from user program? 
> I would like to start debugging from there and see if any thing at all
> happens when there is a call. Appreciate your help with this question.

I don't generally recommend starting debugging at that level, but I'll
try to give you some pointers. Every system call coming into the kernel
from a user space program initially runs a little piece of assembly
language code that looks up a handler (by number) in the system call
table and sets up the proper environment to call the appropriate function
that implements that call (which is written in C). Normally, those
functions are named with a prefix of sys_ and the name of the system
call. For example, the implementation of read(2) is called sys_read. You
should be able to find it in fs/read_write.c. Other system call
implementations are scattered around to be with code related to that
call. Most of the file related ones can be found someplace under the
fs directory.

	Brad Boyer
	flar@allandria.com
