Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Clean up lexing of include files 
In-reply-to: <20080626070857.GA1869@yookeroo.seuss> 
References: <20080626070857.GA1869@yookeroo.seuss>
Date: Mon, 14 Jul 2008 13:55:13 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KITCb-0006rX-Pp@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Currently we scan the /include/ directive as two tokens, the
> "/include/" keyword itself, then the string giving the file name to
> include.  We use a special scanner state to keep the two linked
> together, and use the scanner state stack to keep track of the
> original state while we're parsing the two /include/ tokens.
> 
> This does mean that we need to enable the 'stack' option in flex,
> which results in a not-easily-suppressed warning from the flex
> boilerplate code.  This is mildly irritating.
> 
> However, this two-token scanning of the /include/ directive also has
> some extremely strange edge cases, because there are a variety of
> tokens recognized in all scanner states, including INCLUDE.  For
> example the following strange dts file:
> 
> 	/include/ /dts-v1/;
> 	/ {
> 		 /* ... */
> 	};
> 
> Will be processed successfully with the /include/ being effectively
> ignored: the '/dts-v1/' and ';' are recognized even in INCLUDE state,
> then the ';' transitions us to PROPNODENAME state, throwing away
> INCLUDE, and the previous state is never popped off the stack.  Or
> for another example this construct:
> 	foo /include/ = "somefile.dts"
> will be parsed as though it were:
> 	foo = /include/ "somefile.dts"
> Again, the '=' is scanned without leaving INCLUDE state, then the next
> string triggers the include logic.
> 
> And finally, we use a different regexp for the string with the
> included filename than the normal string regexpt, which is also
> potentially weird.
> 
> This patch, therefore, cleans up the lexical handling of the /include/
> directive.  Instead of the INCLUDE state, we instead scan the whole
> include directive, both keyword and filename as a single token.  This
> does mean a bit more complexity in extracting the filename out of
> yytext, but I think it's worth it to avoid the strageness described
> above.  It also means it's no longer possible to put a comment between
> the /include/ and the filename, but I'm really not very worried about
> breaking files using such a strange construct.

Applied.

jdl
