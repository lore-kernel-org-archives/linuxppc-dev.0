Return-Path: <gjalt007@chello.nl>
Received: from amsfep14-int.chello.nl (amsfep14-int.chello.nl [213.46.243.21])
	by ozlabs.org (Postfix) with ESMTP id E70D168962
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 09:07:42 +1100 (EST)
Message-ID: <43B459C5.1060206@chello.nl>
Date: Thu, 29 Dec 2005 22:48:53 +0100
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <4440987.1134894054475.JavaMail.postfix@mx3.mail.sohu.com>
In-Reply-To: <4440987.1134894054475.JavaMail.postfix@mx3.mail.sohu.com>
Content-Type: text/plain; charset=GB2312
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

Hmm...
I've seen these messages before. They were gone when I compiled using
ppc_8xx-gcc compiler of a different ELDK version.
What version of ELDK are you using? Which gcc version?

Succes,
Theo Gjaltema.

zengshuai@sogou.com schreef:

>[root@localhost atmlz]# ppc_6xx-gcc -c -o temp atm_aalx.c         
>atm_aalx.c: In function `main':                                   
>atm_aalx.c:201: warning: return type of `main' is not `int'       
>/tmp/cciJlehe.s: Assembler messages:                              
>/tmp/cciJlehe.s:916: Error: unsupported relocation against r3     
>/tmp/cciJlehe.s:917: Error: unsupported relocation against r3     
>/tmp/cciJlehe.s:917: Error: unsupported relocation against r3     
>/tmp/cciJlehe.s:918: Error: unsupported relocation against r3     
>/tmp/cciJlehe.s:918: Error: unsupported relocation against r3     
>/tmp/cciJlehe.s:919: Error: unsupported relocation against r3     
>/tmp/cciJlehe.s:3655: Error: unsupported relocation against r3    
>[root@localhost atmlz]# ppc_6xx-gcc -S -o temp.s atm_aalx.c
>[root@localhost atmlz]# vi temp.s
>...................
>        stw 0,4(9)                 
>.L36:                              
>#APP                               
>         mfmsr r3                  
>         ori r3,r3,0x8000          
>         andi. r3,r3,0xffbf        
>         mtmsr r3                  
>#NO_APP                            
>        lwz 11,0(1)                
>..............................
>I must change those "r3" to "3" manually.
>How to fix?
>
>------------------------------
>我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
>http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=linuxppc-embedded&FullName=linuxppc-embedded&Email=linuxppc-embedded%40ozlabs.org&verify=755eff4e640bdcfc57d93cbd8b0a9cb7
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>  
>
