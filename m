Return-Path: <alohanono@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 9B50DDDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Mar 2008 09:11:00 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1055195uge.0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 01 Mar 2008 14:10:58 -0800 (PST)
Message-ID: <47C9D470.5000604@gmail.com>
Date: Sat, 01 Mar 2008 23:10:56 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problems when accessing to registers in GPIO
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

 I am getting some problems when trying to access to the GPIO registers 
from the userland of my secretlab's linux 2.6.24-rc3 ( Xilinx ML403 ). I 
am using io_remap() functions ( from 
http://www.denx.de/wiki/bin/view/PPCEmbedded/DeviceDrivers ) and I was 
successfully able to test them with some own-made IP cores. However, I 
am having problems when trying to do it in the same way with the GPIO IP 
core from Xilinx ( the ones I am using to interface to the LEDs , 
buttons and LCD ).

 If I try to access to the buttons in the board I don't really have any 
problem since the tri-state control register is automatically set to 
"all inputs" when the IP is turned on. But when I try to use the LEDs 
and I need to configure the tris-state as outputs, they don't work . I 
am doing the following:

    //memory mapping
    if(    (led_base = (volatile int*) ioremap(BASE_GPIO,8)) == NULL ||
            (but_base = (volatile int*) ioremap(BASE_GPIO_B, 8)) == NULL )
    {
        perror( "Cannot allocate memory for GPIO/n");
        return 1;
    }
     
    led_tri = (char*)led_base + 0x4;
    but_tri = (char*)but_base + 0x4;

    //configure as inputs and outputs
    printf("configuring IOs...");
    *led_tri = 0x00;//configure them as outputs
    *but_tri = 0xFF;//configure them as inputs

    while(1)
    {
        data = *but_base;
//     printf("data:%x\n",data);
       *led_base = data;
       usleep(50000);
    }   

 If I try to allocate the tri-state registers as integer I get "Bus 
Error" when accessing to them. I don't know really what is the problem. 
If I try to the same without operating system, this is, directly using 
XPS, I manage to make the buttons and leds work perfectly. Anybody can 
help me with this?

/A
