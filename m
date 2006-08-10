Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 37DCE67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 17:10:41 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 9FCBE8780BA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 00:10:21 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r68a001021D-00-2
	for linuxppc-embedded@ozlabs.org; Thu, 10 Aug 2006 00:10:21 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 601308780A7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 00:10:21 -0700 (PDT)
Message-ID: <44DADBDB.1050806@gmail.com>
Date: Thu, 10 Aug 2006 12:40:19 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: regarding pci  vga card output with powerpc
References: <44D7097C.7040907@gmail.com> <44DA6A72.7020502@varma-el.com>
	<44DABF53.5020908@gmail.com> <44DACE0E.2050505@varma-el.com>
In-Reply-To: <44DACE0E.2050505@varma-el.com>
Content-Type: multipart/alternative;
	boundary="------------070902060505080600090709"
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

This is a multi-part message in MIME format.
--------------070902060505080600090709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrey Volkov wrote:
> sudheer wrote:
>   
>> Andrey Volkov wrote:
>>     
>>> urwithsudheer wrote:
>>>       
>>>> Hello All,
>>>> I am working with a pci based vga card. I have connected the vga card
>>>> next to the  pci slot of my target processor on the baseboard.
>>>> I have connected a monitor to the vga card.
>>>> When i boot linux from minicom, i could see all the kernel log
>>>> messages on both the minicom and vga card monitor. But on the vga
>>>> monitor, i could not see any messages after asking for login as below:
>>>> .
>>>> .
>>>>
>>>> Mounting filesystems
>>>> Running depmod
>>>> Setting up networking on loopback device:
>>>> Setting up networking on eth0:
>>>> eth0: PHY is Marvell 88E11x1 (1410cc2)
>>>> Adding static route for default gateway to 192.168.3.1:
>>>> Setting nameserver to 192.168.0.1 in /etc/resolv.conf:
>>>> Starting inetd:
>>>>
>>>> login:
>>>>
>>>>
>>>> Though i am entering my login and passwd at the minicom, nothing
>>>> comes on to the vga monitor. But i am able to write to vga monitor
>>>> using the following commands from minicom:
>>>>
>>>> # echo "Hello" > /dev/tty1
>>>> # echo "Hi " > /dev/tty1
>>>> My requirement is to get on the vga monitor whatever i am typing on
>>>> the minicom after logging into the linux like .
>>>> ls or pwd commands.
>>>>
>>>> Anyone pl help me.
>>>>
>>>> Thanks & Regards
>>>> Sudheer
>>>>
>>>>         
>>> See Documentation/kernel-parameters.txt.
>>>
>>> If be short, add:
>>>
>>>     console=/dev/ttySxx console=/dev/tty1
>>>
>>> (both) to a kernel parameters string.
>>>
>>>       
>> I got upto login prompt on the vga monitor only after giving the above
>> parameters in my u-boot bootargs.
>> u-boot=> set bootargs console=tty1 console=ttyS0,115200.
>>
>>
>> I have added in the serial driver  linux/drivers/serial/serial_core.c
>>    in the function  uart_write(struct tty_struct *tty, const unsigned
>> char * buf, int count)
>>    The lines in the if directive.
>>   
>> if (c <= 0)
>>                         break;
>>                 memcpy(circ->buf + circ->head, buf, c);
>> /* added to test vga */
>> #if 1
>>                 memcpy(tempbuf, circ->buf + circ->head, c);
>>                   for(i=0;i<c;i++)
>>                   printk("%c", tempbuf[i]);
>> #endif
>>
>>  circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
>>                 buf += c;
>>
>> Then as i expected, all the letters i enter in the minicom came twice on
>> the minicom.
>>     
>
> Because printk didn't print to an dedicated device, but to a klog
> stream. So check your /etc/inittab and /etc/securetty, its similar
> that something wrong in this files.
>   
oh..sorry, i forgot to tell you about the other two modifications done 
in the kernel config and ramdisk.
In the kernel config-- I have selected the virtual terminal option.
In the ramdisk- etc/inittab - i added the following line:
::respawn:/sbin/getty tty1 115200 vt100.
The etc/securetty contains the following:
console
fb0
tty1
tty2
tty3
tty4
tty5
tty6
tty7
tty8
ttyS0
ttyS1
ttyS2
ttyS3
ttyp0
ttyp1
ttyp2
ttyp3
ttyAM0
ttyAM1
tts/0
tts/1

Do i need to use fb0, to send the  serial data to frame buffer ?

>   
>> login:rroooott
>> Password: Password:
>> login  on `ttyS0'ogin  on `ttyS0'login[83]: root
>>
>>  ~ # ~ # llss
>>  ~ # ~ # iiffccoonnffiigg
>>
>> And whatever i enter on the minicom also gets print on the vga monitor 
>> but only once.
>> When i comment the if directive, On the vga monitor i could see only
>> upto login prompt.
>>
>> I don't know why the printk statement i added in the serial driver
>> prints on the vga monitor.
>>
>> As said by shkatikannan, i am going through the vga driver to copy to
>> the frambuffer. But  yet couldn't get it exactly in the code where to copy.
>>
>> Please tell me if i am in the wrong path.
>>
>> Thanks & Regards
>> Sudheer
>>
>>     


--------------070902060505080600090709
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Andrey Volkov wrote:
<blockquote cite="mid44DACE0E.2050505@varma-el.com" type="cite">
  <pre wrap="">sudheer wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Andrey Volkov wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">urwithsudheer wrote:
      </pre>
      <blockquote type="cite">
        <pre wrap="">Hello All,
I am working with a pci based vga card. I have connected the vga card
next to the  pci slot of my target processor on the baseboard.
I have connected a monitor to the vga card.
When i boot linux from minicom, i could see all the kernel log
messages on both the minicom and vga card monitor. But on the vga
monitor, i could not see any messages after asking for login as below:
.
.

Mounting filesystems
Running depmod
Setting up networking on loopback device:
Setting up networking on eth0:
eth0: PHY is Marvell 88E11x1 (1410cc2)
Adding static route for default gateway to 192.168.3.1:
Setting nameserver to 192.168.0.1 in /etc/resolv.conf:
Starting inetd:

login:


Though i am entering my login and passwd at the minicom, nothing
comes on to the vga monitor. But i am able to write to vga monitor
using the following commands from minicom:

# echo "Hello" &gt; /dev/tty1
# echo "Hi " &gt; /dev/tty1
My requirement is to get on the vga monitor whatever i am typing on
the minicom after logging into the linux like .
ls or pwd commands.

Anyone pl help me.

Thanks &amp; Regards
Sudheer

        </pre>
      </blockquote>
      <pre wrap="">See Documentation/kernel-parameters.txt.

If be short, add:

    console=/dev/ttySxx console=/dev/tty1

(both) to a kernel parameters string.

      </pre>
    </blockquote>
    <pre wrap="">I got upto login prompt on the vga monitor only after giving the above
parameters in my u-boot bootargs.
u-boot=&gt; set bootargs console=tty1 console=ttyS0,115200.


I have added in the serial driver  linux/drivers/serial/serial_core.c
   in the function  uart_write(struct tty_struct *tty, const unsigned
char * buf, int count)
   The lines in the if directive.
  
if (c &lt;= 0)
                        break;
                memcpy(circ-&gt;buf + circ-&gt;head, buf, c);
/* added to test vga */
#if 1
                memcpy(tempbuf, circ-&gt;buf + circ-&gt;head, c);
                  for(i=0;i&lt;c;i++)
                  printk("%c", tempbuf[i]);
#endif

 circ-&gt;head = (circ-&gt;head + c) &amp; (UART_XMIT_SIZE - 1);
                buf += c;

Then as i expected, all the letters i enter in the minicom came twice on
the minicom.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Because printk didn't print to an dedicated device, but to a klog
stream. So check your /etc/inittab and /etc/securetty, its similar
that something wrong in this files.
  </pre>
</blockquote>
oh..sorry, i forgot to tell you about the other two modifications done
in the kernel config and ramdisk.<br>
In the kernel config-- I have selected the virtual terminal option.<br>
In the ramdisk- etc/inittab - i added the following line:<br>
::respawn:/sbin/getty tty1 115200 vt100.<br>
The etc/securetty contains the following:<br>
console<br>
fb0<br>
tty1<br>
tty2<br>
tty3<br>
tty4<br>
tty5<br>
tty6<br>
tty7<br>
tty8<br>
ttyS0<br>
ttyS1<br>
ttyS2<br>
ttyS3<br>
ttyp0<br>
ttyp1<br>
ttyp2<br>
ttyp3<br>
ttyAM0<br>
ttyAM1<br>
tts/0<br>
tts/1<br>
<br>
Do i need to use fb0, to send the&nbsp; serial data to frame buffer ?<br>
<br>
<blockquote cite="mid44DACE0E.2050505@varma-el.com" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">login:rroooott
Password: Password:
login  on `ttyS0'ogin  on `ttyS0'login[83]: root

 ~ # ~ # llss
 ~ # ~ # iiffccoonnffiigg

And whatever i enter on the minicom also gets print on the vga monitor 
but only once.
When i comment the if directive, On the vga monitor i could see only
upto login prompt.

I don't know why the printk statement i added in the serial driver
prints on the vga monitor.

As said by shkatikannan, i am going through the vga driver to copy to
the frambuffer. But  yet couldn't get it exactly in the code where to copy.

Please tell me if i am in the wrong path.

Thanks &amp; Regards
Sudheer

    </pre>
  </blockquote>
</blockquote>
<br>
</body>
</html>

--------------070902060505080600090709--
