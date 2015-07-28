Return-Path: <segher@gate.crashing.org>
Date: Tue, 28 Jul 2015 12:04:16 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Thomas Huth <thuth@redhat.com>
Cc: slof@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@ozlabs.ru,
 linuxppc-dev@lists.ozlabs.org, gkurz@linux.vnet.ibm.com
Subject: Re: [SLOF PATCH 1/2] fbuffer: Improve invert-region helper
Message-ID: <20150728170416.GB28839@gate.crashing.org>
References: <1438078795-14360-1-git-send-email-thuth@redhat.com>
 <1438078795-14360-2-git-send-email-thuth@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438078795-14360-2-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 28, 2015 at 12:19:54PM +0200, Thomas Huth wrote:
>  : invert-region ( addr len -- )
> -   0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
> -;
> -
> -: invert-region-x ( addr len -- )
> -   /x / 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP drop
> +   2dup or 7 and CASE
> +      0 OF 3 rshift 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP ENDOF
> +      2 OF 1 rshift 0 ?DO dup dup rw@ -1 xor swap rw! wa1+ LOOP ENDOF
> +      4 OF 2 rshift 0 ?DO dup dup rl@ -1 xor swap rl! la1+ LOOP ENDOF
> +      6 OF 1 rshift 0 ?DO dup dup rw@ -1 xor swap rw! wa1+ LOOP ENDOF
> +      dup OF 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP ENDOF
> +   ENDCASE
> +   drop
>  ;

Can you access device memory as 64 bits for all supported devices?

You can get a bigger speedup by writing some of the core blitting
functions in C, btw.

A small simplification:

   2dup or 7 and CASE
      0 OF 3 rshift 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP ENDOF
      4 OF 2 rshift 0 ?DO dup dup rl@ -1 xor swap rl! la1+ LOOP ENDOF
      3 and
      2 OF 1 rshift 0 ?DO dup dup rw@ -1 xor swap rw! wa1+ LOOP ENDOF
      dup OF 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP ENDOF
   ENDCASE


If this code is often called unaligned, it makes more sense to special-
case the begin and end probably.


Segher
