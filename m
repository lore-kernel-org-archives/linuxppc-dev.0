Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70E9D1A0C65
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 17:38:36 +1100 (AEDT)
Date: Fri, 4 Dec 2015 06:38:25 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: more POLL... fun
Message-ID: <20151204063825.GH22011@ZenIV.linux.org.uk>
References: <20151127050026.GX22011@ZenIV.linux.org.uk>
 <20151127131843.0416fe2b@recife.lan>
 <CA+55aFw-9Y6c-wgiXkyFuce7bqA-RQsRUuW6wC42ayoN4nVo6g@mail.gmail.com>
 <20151130030427.GY22011@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151130030427.GY22011@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On cross-builds the __poll_t annotations had caught something interesting:
void spufs_mfc_callback(struct spu *spu)
{
	....
                mask = 0;
                if (free_elements & 0xffff)
                        mask |= POLLOUT;
                if (tagstatus & ctx->tagwait)
                        mask |= POLLIN;

                kill_fasync(&ctx->mfc_fasync, SIGIO, mask);
	....
}

That's arch/powerpc/platforms/cell/spufs/file.c.  WTF is kill_fasync()
getting as the last argument here?  Valid values are
#define POLL_IN         (__SI_POLL|1)   /* data input available */
#define POLL_OUT        (__SI_POLL|2)   /* output buffers available */
#define POLL_MSG        (__SI_POLL|3)   /* input message available */
#define POLL_ERR        (__SI_POLL|4)   /* i/o error */
#define POLL_PRI        (__SI_POLL|5)   /* high priority input available */
#define POLL_HUP        (__SI_POLL|6)   /* device disconnected */

Use of POLLIN, POLLOUT, etc. here is wrong - kill_fasync() will step into
                        BUG_ON((reason & __SI_MASK) != __SI_POLL);
in send_sigio_to_task().  Other two callers of kill_fasync() in that file
are trivially fixed by switching to POLL_IN and POLL_OUT; with this one
I've no idea what had been intended.

What's more, I really wonder if it had _ever_ been tested - these kill_fasync()
calls had been introduced in
commit 8b3d6663c6217e4f50cc3720935a96da9b984117
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Nov 15 15:53:52 2005 -0500

    [PATCH] spufs: cooperative scheduler support
more than 5 years after that BUG_ON() had been added - it goes back to
+                       /* Make sure we are called with one of the POLL_*
+                          reasons, otherwise we could leak kernel stack into
+                          userspace.  */
+                       if ((reason & __SI_MASK) != __SI_POLL)
+                               BUG();
in 2.3.99pre-10-3, on May 25 2000.

What the hell am I missing here?  Has that code been DOA and never used by
anyone in all the decade it had been in mainline?
