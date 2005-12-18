Return-Path: <zengshuai@sogou.com>
Received: from sogoumx75.mail.sogou.com (unknown [61.135.132.136])
	by ozlabs.org (Postfix) with ESMTP id 10781688DC
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Dec 2005 19:33:47 +1100 (EST)
Received: from mx3.mail.sohu.com (unknown [192.168.95.78])
	by sogoumx75.mail.sogou.com (Postfix) with ESMTP id E032053411B0
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Dec 2005 16:33:37 +0800 (CST)
Message-ID: <4440987.1134894054475.JavaMail.postfix@mx3.mail.sohu.com>
Date: Sun, 18 Dec 2005 16:20:54 +0800 (CST)
From: <zengshuai@sogou.com>
To: "ppc" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Subject: eldk bug?how to fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[root@localhost atmlz]# ppc_6xx-gcc -c -o temp atm_aalx.c         
atm_aalx.c: In function `main':                                   
atm_aalx.c:201: warning: return type of `main' is not `int'       
/tmp/cciJlehe.s: Assembler messages:                              
/tmp/cciJlehe.s:916: Error: unsupported relocation against r3     
/tmp/cciJlehe.s:917: Error: unsupported relocation against r3     
/tmp/cciJlehe.s:917: Error: unsupported relocation against r3     
/tmp/cciJlehe.s:918: Error: unsupported relocation against r3     
/tmp/cciJlehe.s:918: Error: unsupported relocation against r3     
/tmp/cciJlehe.s:919: Error: unsupported relocation against r3     
/tmp/cciJlehe.s:3655: Error: unsupported relocation against r3    
[root@localhost atmlz]# ppc_6xx-gcc -S -o temp.s atm_aalx.c
[root@localhost atmlz]# vi temp.s
...................
        stw 0,4(9)                 
.L36:                              
#APP                               
         mfmsr r3                  
         ori r3,r3,0x8000          
         andi. r3,r3,0xffbf        
         mtmsr r3                  
#NO_APP                            
        lwz 11,0(1)                
..............................
I must change those "r3" to "3" manually.
How to fix?

------------------------------
我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=linuxppc-embedded&FullName=linuxppc-embedded&Email=linuxppc-embedded%40ozlabs.org&verify=755eff4e640bdcfc57d93cbd8b0a9cb7
