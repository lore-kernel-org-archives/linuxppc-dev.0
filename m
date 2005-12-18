Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 70D9D688E5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 01:44:56 +1100 (EST)
To: zengshuai@sogou.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 18 Dec 2005 16:20:54 +0800."
	<4440987.1134894054475.JavaMail.postfix@mx3.mail.sohu.com>
Date: Sun, 18 Dec 2005 15:44:53 +0100
Sender: wd@denx.de
Message-Id: <20051218144453.68024352B33@atlas.denx.de>
Cc: ppc <linuxppc-embedded@ozlabs.org>
Subject: Re: eldk bug?how to fix 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4440987.1134894054475.JavaMail.postfix@mx3.mail.sohu.com> you wrote:
> [root@localhost atmlz]# ppc_6xx-gcc -c -o temp atm_aalx.c         
> atm_aalx.c: In function `main':                                   
> atm_aalx.c:201: warning: return type of `main' is not `int'       
> /tmp/cciJlehe.s: Assembler messages:                              
> /tmp/cciJlehe.s:916: Error: unsupported relocation against r3     
> /tmp/cciJlehe.s:917: Error: unsupported relocation against r3     
> /tmp/cciJlehe.s:917: Error: unsupported relocation against r3     
> /tmp/cciJlehe.s:918: Error: unsupported relocation against r3     
> /tmp/cciJlehe.s:918: Error: unsupported relocation against r3     
> /tmp/cciJlehe.s:919: Error: unsupported relocation against r3     
> /tmp/cciJlehe.s:3655: Error: unsupported relocation against r3    

Are you by any chance using inline  assembler  code  in  your  source
file?  This  is  the  only  explanation  I  have,  since GCC does not
generate "r3" references in it's assembler code.

It would have been a good idea if you had included your  source  code
so we could see what you are doing...

> [root@localhost atmlz]# ppc_6xx-gcc -S -o temp.s atm_aalx.c
> [root@localhost atmlz]# vi temp.s
> ...................
>         stw 0,4(9)                 
> .L36:                              
> #APP                               
>          mfmsr r3                  
>          ori r3,r3,0x8000          
>          andi. r3,r3,0xffbf        
>          mtmsr r3                  
> #NO_APP                            
>         lwz 11,0(1)                
> ..............................

I see. This is your own assembler code, not something generated  from
C source code.

> I must change those "r3" to "3" manually.
> How to fix?

Don't write incorrect assembler code,  or  use  the  required  header
files (like ppc_asm.tmpl).

And while we are at it: be careful not to try privileged instructions
in user space.



This is your own error, not a problem with ELDK.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If I had to live my life again,  I'd  make  the  same  mistakes, only
sooner.                                          -- Tallulah Bankhead
