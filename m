Return-Path: <hongwoo7@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 732F4B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 18:46:58 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id f25so433256rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 07 Aug 2009 01:46:57 -0700 (PDT)
Message-ID: <4A7BEA04.7030006@gmail.com>
Date: Fri, 07 Aug 2009 17:47:00 +0900
From: HongWoo Lee <hongwoo7@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Question about powerpc branch instructions
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi~

I want to know about bl instruction and the difference between branch 
instructions.
I found this code segment.

{{{
....
bl  go_to_real
insrdi  r18, r19, 32, 0
....
}}}

And I found the explanation about branch instructions in PowerISA 2.06 
document.

{{{
b target_addr (AA=0 LK=0)
ba target_addr (AA=1 LK=0)
bl target_addr (AA=0 LK=1)
bla target_addr (AA=1 LK=1)

If AA=0 then the branch target address is the sum of LI || 0b00 
sign-extended and the address of this instruction,
with the high-order 32 bits of the branch target address set to 0 in 
32-bit mode.

If AA=1 then the branch target address is the value LI || 0b00 
sign-extended,
with the high-order 32 bits of the branch target address set to 0 in 
32-bit mode.

If LK=1 then the effective address of the instruction following the 
Branch instruction is placed into the Link Register.
}}}

Questions
#1: Is there any special reason to concatenate 0b00 ?  Why 0b00 ??
#2: Is b similar to the jmp in x86 ? and bl is similar to the call in x86 ?

Thanks in advance.

HongWoo.
