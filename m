Message-ID: <3CC82BD3.7020201@mvista.com>
Date: Thu, 25 Apr 2002 09:16:19 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Jacky Wang <jacky@premierme.com.tw>
Cc: boehringer@snom.de, Fend Matthias <mfend@harris.com>,
	jimmlin@solomon.com.tw,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: AW: Does anyone port m8xx_pcmcia driver to Linux Kernel  successfully?
References: <NFBBLKLHNAGPKBMPDMALAEMJKAAA.jacky@premierme.com.tw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The m8xx socket driver did not get loaded.  Turn on some debug in the
pcmcia code.  What is your h/w?

Jacky Wang wrote:

>Hi all,
>
>I tried the patch with standard linux kernel 2.4.18 with hand-patching.
>
>I can re-compile with the patch (link into the kernel image, not load as a module).
>But, while I attach a ne2000 compatible pcmcia card, it looks can't load the ethernet card driver or can't detect the card.
>
>here is the pcmcia card I used: Zonet 10Base Ethernet Card.
>
>the attachment is the image I load into by ppcboot 1.1.4 and the log file.
>
>Jacky
>
>>-----Original Message-----
>>From: owner-linuxppc-embedded@lists.linuxppc.org
>>[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
>>Sven Boehringer
>>Sent: Thursday, April 25, 2002 5:34 PM
>>To: Matthew Locke; Fend Matthias; jimmlin@solomon.com.tw; linuxppc
>>Subject: Re: AW: Does anyone port m8xx_pcmcia driver to Linux
>>Kernel successfully?
>>
>>
>>
>>Hi all,
>>
>>i tried your patch, but it seems to me that there are some #defines
>>missing?
>>I try to use the source/kernel on a FADS board, an in that section there
>>is
>>"BCSR1_PCCVPP1". But i can't find this value. I tried to copy some
>>values from ppcboot,
>>but these particular are not there. Are there some special includes?
>>
>>I have the actual linuxppc_2_4_devel source-tree, but i can't find these
>>values.
>>
>>regards
>>	Sven
>>
>>Matthew Locke wrote:
>>
>>>here is the patch to add the 8xx pcmcia socket driver to the kernel.
>>>
>>>Fend, Matthias wrote:
>>>
>>>>hello Matthew,
>>>>
>>>>i also tried to do this work - without the desired success
>>>>
>>>>i don't know exactly if my hardware is faulty or my m8xx port ... :-(
>>>>
>>>>so if i could have your version of the pcmcia stuff i would be
>>>>
>>very glad.
>>
>>>>thanks matthias
>>>>
>>>>>-----Ursprüngliche Nachricht-----
>>>>>Von:  Matthew Locke [SMTP:mlocke@mvista.com]
>>>>>Gesendet am:  Dienstag, 16. April 2002 18:50
>>>>>An:   Jacky Wang
>>>>>Cc:   linuxppc-embedded@lists.linuxppc.org
>>>>>Betreff:      Re: Does anyone port m8xx_pcmcia driver to Linux Kernel
>>>>>successfully?
>>>>>
>>>>>
>>>>>Jacky Wang wrote:
>>>>>
>>>>>>Hi everyone,
>>>>>>
>>>>>>I am interesting about how to port m8xx_pcmcia driver to
>>>>>>
>>linux kernel w/
>>
>>>>>MPC850.
>>>>>
>>>>>>Would you mind to share your successful experience with me?
>>>>>>
>>>>>I did (w/ the help of others). It is on its way upstream now. If you
>>>>>need it soon, let me know and I can make it available.
>>>>>
>>>>>>Best Regards
>>>>>>Jacky Wang
>>>>>>
>>>>>>
>>>>>** Sent via the linuxppc-embedded mail list. See
>>>>>
>>http://lists.linuxppc.org
>>
>>>>/
>>>>
>>>+/*
>>>
>>------------------------------------------------------------------
>>------- */
>>
>>>+/* FADS Boards from Motorola
>>>
>>            */
>>
>>>+
>>>+#if defined(CONFIG_FADS)
>>>+
>>>+#define PCMCIA_BOARD_MSG "FADS"
>>>+
>>>+static int voltage_set(int slot, int vcc, int vpp)
>>>+{
>>>+       uint reg = 0;
>>>+
>>>+       switch(vcc) {
>>>+               case 0: break;
>>>+               case 33: reg |= BCSR1_PCCVCC0; break;
>>>+               case 50: reg |= BCSR1_PCCVCC1; break;
>>>+               default: return 1;
>>>+       }
>>>+
>>>+       switch(vpp) {
>>>+               case 0: break;
>>>+               case 33:
>>>+               case 50:
>>>+                       if(vcc == vpp)
>>>+                               reg |= BCSR1_PCCVPP1;
>>>+                       else
>>>+                               return 1;
>>>+                       break;
>>>+               case 120:
>>>+                       if ((vcc == 33) || (vcc == 50))
>>>+                               reg |= BCSR1_PCCVPP0;
>>>+                       else
>>>+                               return 1;
>>>+               default: return 1;
>>>+       }
>>>+
>>>+       /* first, turn off all power */
>>>+       *((uint *)BCSR1) &= ~(BCSR1_PCCVCC_MASK | BCSR1_PCCVPP_MASK);
>>>+
>>>+       /* enable new powersettings */
>>>+       *((uint *)BCSR1) |= reg;
>>>+
>>>+       return 0;
>>>+}
>>>+
>>>+#define socket_get(_slot_) PCMCIA_SOCKET_KEY_5V
>>>+
>>>+static void hardware_enable(int slot)
>>>+{
>>>+       *((uint *)BCSR1) &= ~BCSR1_PCCEN;
>>>+}
>>>+
>>>+static void hardware_disable(int slot)
>>>+{
>>>+       *((uint *)BCSR1) |=  BCSR1_PCCEN;
>>>+}
>>>+
>>>+#endif
>>>+
>>>
>>** Sent via the linuxppc-embedded mail list. See
>>
>http://lists.linuxppc.org/
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
