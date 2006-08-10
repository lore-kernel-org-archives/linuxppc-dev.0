Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [195.144.240.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 26E2967A3D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 16:11:32 +1000 (EST)
Message-ID: <44DACE0E.2050505@varma-el.com>
Date: Thu, 10 Aug 2006 10:11:26 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: regarding pci  vga card output with powerpc
References: <44D7097C.7040907@gmail.com> <44DA6A72.7020502@varma-el.com>
	<44DABF53.5020908@gmail.com>
In-Reply-To: <44DABF53.5020908@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

sudheer wrote:
> Andrey Volkov wrote:
>> urwithsudheer wrote:
>>> Hello All,
>>> I am working with a pci based vga card. I have connected the vga card
>>> next to the  pci slot of my target processor on the baseboard.
>>> I have connected a monitor to the vga card.
>>> When i boot linux from minicom, i could see all the kernel log
>>> messages on both the minicom and vga card monitor. But on the vga
>>> monitor, i could not see any messages after asking for login as below:
>>> .
>>> .
>>>
>>> Mounting filesystems
>>> Running depmod
>>> Setting up networking on loopback device:
>>> Setting up networking on eth0:
>>> eth0: PHY is Marvell 88E11x1 (1410cc2)
>>> Adding static route for default gateway to 192.168.3.1:
>>> Setting nameserver to 192.168.0.1 in /etc/resolv.conf:
>>> Starting inetd:
>>>
>>> login:
>>>
>>>
>>> Though i am entering my login and passwd at the minicom, nothing
>>> comes on to the vga monitor. But i am able to write to vga monitor
>>> using the following commands from minicom:
>>>
>>> # echo "Hello" > /dev/tty1
>>> # echo "Hi " > /dev/tty1
>>> My requirement is to get on the vga monitor whatever i am typing on
>>> the minicom after logging into the linux like .
>>> ls or pwd commands.
>>>
>>> Anyone pl help me.
>>>
>>> Thanks & Regards
>>> Sudheer
>>>
>>
>> See Documentation/kernel-parameters.txt.
>>
>> If be short, add:
>>
>>     console=/dev/ttySxx console=/dev/tty1
>>
>> (both) to a kernel parameters string.
>>
> I got upto login prompt on the vga monitor only after giving the above
> parameters in my u-boot bootargs.
> u-boot=> set bootargs console=tty1 console=ttyS0,115200.
> 
> 
> I have added in the serial driver  linux/drivers/serial/serial_core.c
>    in the function  uart_write(struct tty_struct *tty, const unsigned
> char * buf, int count)
>    The lines in the if directive.
>   
> if (c <= 0)
>                         break;
>                 memcpy(circ->buf + circ->head, buf, c);
> /* added to test vga */
> #if 1
>                 memcpy(tempbuf, circ->buf + circ->head, c);
>                   for(i=0;i<c;i++)
>                   printk("%c", tempbuf[i]);
> #endif
> 
>  circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
>                 buf += c;
> 
> Then as i expected, all the letters i enter in the minicom came twice on
> the minicom.

Because printk didn't print to an dedicated device, but to a klog
stream. So check your /etc/inittab and /etc/securetty, its similar
that something wrong in this files.

> 
> login:rroooott
> Password: Password:
> login  on `ttyS0'ogin  on `ttyS0'login[83]: root
> 
>  ~ # ~ # llss
>  ~ # ~ # iiffccoonnffiigg
> 
> And whatever i enter on the minicom also gets print on the vga monitor 
> but only once.
> When i comment the if directive, On the vga monitor i could see only
> upto login prompt.
> 
> I don't know why the printk statement i added in the serial driver
> prints on the vga monitor.
> 
> As said by shkatikannan, i am going through the vga driver to copy to
> the frambuffer. But  yet couldn't get it exactly in the code where to copy.
> 
> Please tell me if i am in the wrong path.
> 
> Thanks & Regards
> Sudheer
> 
-- 
Regards
Andrey
