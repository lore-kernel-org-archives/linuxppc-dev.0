Date: Fri, 31 Mar 2000 13:11:40 +1000 (EST)
From: Alan Modra <alan@linuxcare.com.au>
To: Brad Parker <brad@parker.boston.ma.us>
cc: binutils@sourceware.cygnus.com, linuxppc-dev@lists.linuxppc.org,
        dan@netx4.com, maxwell@parc.xerox.com, patrik@ucolick.org
Subject: Re: gprof on powerpc fails if compiled with older gcc
In-Reply-To: <200003302040.PAA69395@p2.parker.boston.ma.us>
Message-ID: <Pine.LNX.4.21.0003311257500.19486-100000@front.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 30 Mar 2000, Brad Parker wrote:

> in malloc.  Turns out the real crash is caused by a bug in gcc which
> messes up a structure copy if the lvalue is a post incremented pointer...

Thanks for the report.  I checked in your workaround since it is simple
and it's good practice anyway to only use {post,pre}{increment,decrement}
dereferenced pointers when both sides of an assignment have the same
post/pre operator.  Putting the dst++ on a separate line makes it more
obvious when skimming through code that there's no corresponding src++.
<
--- gprof/symtab.c~	Wed Jul  7 23:02:44 1999
+++ gprof/symtab.c	Fri Mar 31 12:40:32 2000
@@ -132,7 +132,8 @@
 	  /* retain sym only if it has a non-empty address range: */
 	  if (!src->end_addr || src->addr <= src->end_addr)
 	    {
-	      *dst++ = *src;
+	      *dst = *src;
+	      dst++;
 	      prev_addr = src->addr;
 	    }
 	}

--
Linuxcare.  Support for the Revolution.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
