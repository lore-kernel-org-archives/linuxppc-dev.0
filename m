Message-ID: <3F17931A.4000405@dgt-lab.com.pl>
Date: Fri, 18 Jul 2003 08:26:34 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: need a fast byteorder changing routine
References: <Xx969281867387.18796@webmail1.inner-21cn.com>
In-Reply-To: <Xx969281867387.18796@webmail1.inner-21cn.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


U¿ytkownik li napisa³:

>Hi all,
>i need do a lot of byteorder changing operation from big-endian to little-endian. cpu_to_le32 is not fast enough for me, does anyone have such a routine written in asm.?
>PS: here is an ugly asm function do such thing:
>void swapbyte(unsigned long *val, unsigned long offset,
>              unsigned long value)
>{
>
>        asm ("lis 3 %0@ha" : "=r" (val));
>        asm ("lwz 3,%0@l(3)" : "=r" (val));
>        asm ("stw %1, 0(4)" : "=r" (offset));
>        asm ("stw %2, 0(5)" : "=r" (value));
>        asm ("stwbrx 5, 3, 4");
>}val is the address of value. i used to set this function as inline, but kernel said:
>Oops: kernel access of bad area, sig: 11
>Any comments
>Best Regards!
>Li
>
>
>
>
>
try DIRECT using out_le16/32 in_le16/32 from <asm/io.h>,
this takes same time as one  big endian write/read



--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
