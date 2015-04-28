Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id C69901A0BEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 05:01:30 +1000 (AEST)
Message-ID: <553FD904.8000309@c-s.fr>
Date: Tue, 28 Apr 2015 21:01:24 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v2,2/2] powerpc32: add support for csum_add()
References: <20150203113927.8604D1A5F14@localhost.localdomain>
 <20150325013023.GA7588@home.buserror.net>
In-Reply-To: <20150325013023.GA7588@home.buserror.net>
Content-Type: multipart/alternative;
 boundary="------------010106020304040902090708"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010106020304040902090708
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/03/2015 02:30, Scott Wood a écrit :
> On Tue, Feb 03, 2015 at 12:39:27PM +0100, LEROY Christophe wrote:
>> The C version of csum_add() as defined in include/net/checksum.h gives the
>> following assembly:
>>         0:       7c 04 1a 14     add     r0,r4,r3
>>         4:       7c 64 00 10     subfc   r3,r4,r0
>>         8:       7c 63 19 10     subfe   r3,r3,r3
>>         c:       7c 63 00 50     subf    r3,r3,r0
>>
>> include/net/checksum.h also offers the possibility to define an arch specific
>> function.
>> This patch provides a ppc32 specific csum_add() inline function.
> What makes it 32-bit specific?
>
>
As far as I understand, the 64-bit will do a 64 bit addition, so we will 
have to handle differently the carry, can't just be an addze like in 32-bit.

The generated code is most likely different on ppc64. I have no ppc64 
compiler so I can't check what gcc generates for the following code:

|__wsumcsum_add(__wsum csum,  __wsum addend)
{
	u32 res= (__force u32)csum;
	res+= (__force u32)addend;
	return  (__force __wsum)(res+ (res< (__force u32)addend));
}|


Can someone with a ppc64 compiler tell what we get ?

Christophe


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
http://www.avast.com

--------------010106020304040902090708
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <br>
    <div class="moz-cite-prefix">Le 25/03/2015 02:30, Scott Wood a
      écrit :<br>
    </div>
    <blockquote cite="mid:20150325013023.GA7588@home.buserror.net"
      type="cite">
      <pre wrap="">On Tue, Feb 03, 2015 at 12:39:27PM +0100, LEROY Christophe wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">The C version of csum_add() as defined in include/net/checksum.h gives the
following assembly:
       0:       7c 04 1a 14     add     r0,r4,r3
       4:       7c 64 00 10     subfc   r3,r4,r0
       8:       7c 63 19 10     subfe   r3,r3,r3
       c:       7c 63 00 50     subf    r3,r3,r0

include/net/checksum.h also offers the possibility to define an arch specific
function.
This patch provides a ppc32 specific csum_add() inline function.
</pre>
      </blockquote>
      <pre wrap="">
What makes it 32-bit specific?


</pre>
    </blockquote>
    As far as I understand, the 64-bit will do a 64 bit addition, so we
    will have to handle differently the carry, can't just be an addze
    like in 32-bit.<br>
    <br>
    The generated code is most likely different on ppc64. I have no
    ppc64 compiler so I can't check what gcc generates for the following
    code:<br>
    <br>
    <pre style="padding: 0px; margin: 0px; color: rgb(0, 0, 0); font-size: 13.3333330154419px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);"><code>__wsum <span class="hl kwd" style="color: rgb(1, 1, 129);">csum_add</span><span class="hl opt">(</span>__wsum csum<span class="hl opt">,</span> __wsum addend<span class="hl opt">)</span>
<span class="hl opt">{</span>
	u32 res <span class="hl opt">= (</span>__force u32<span class="hl opt">)</span>csum<span class="hl opt">;</span>
	res <span class="hl opt">+= (</span>__force u32<span class="hl opt">)</span>addend<span class="hl opt">;</span>
	<span class="hl kwa" style="color: rgb(0, 0, 0); font-weight: bold;">return</span> <span class="hl opt">(</span>__force __wsum<span class="hl opt">)(</span>res <span class="hl opt">+ (</span>res <span class="hl opt">&lt; (</span>__force u32<span class="hl opt">)</span>addend<span class="hl opt">));</span>
<span class="hl opt">}</span></code></pre>
    <br>
    Can someone with a ppc64 compiler tell what we get ?<br>
    <br>
    Christophe<br>
  
<br /><br />
<hr style='border:none; color:#909090; background-color:#B0B0B0; height: 1px; width: 99%;' />
<table style='border-collapse:collapse;border:none;'>
	<tr>
		<td style='border:none;padding:0px 15px 0px 8px'>
			<a href="http://www.avast.com/">
				<img border=0 src="http://static.avast.com/emails/avast-mail-stamp.png" alt="Avast logo" />
			</a>
		</td>
		<td>
			<p style='color:#3d4d5a; font-family:"Calibri","Verdana","Arial","Helvetica"; font-size:12pt;'>
				L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
				<br><a href="http://www.avast.com/">www.avast.com</a>
			</p>
		</td>
	</tr>
</table>
<br />
</body>
</html>

--------------010106020304040902090708--
