To: "Juan Padron" <j_padron@joseane.zzn.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CONFIG_IDE_PCCARD or CONFIG_IDE_PCMCIA 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 15 Nov 2001 10:43:18 +0100."
             <C398751347F4533458DB3F93154AAAFD@j_padron.joseane.zzn.com>
Date: Thu, 15 Nov 2001 11:15:19 +0100
Message-Id: <20011115101524.6820010DDC@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Juan,

in message <C398751347F4533458DB3F93154AAAFD@j_padron.joseane.zzn.com> you wrote:
>
>   I need to put and IDE disk through the PCMCIA port in an MPC823FADS. I use the ppcboot 1.0.0
> I read the mailing list and i have a doubt: What is the diference between the IDE_PCCARD and the IDE_PCMCIA? What do i need to use?

If you have a real PCCard slot on your board you must use IDE_PCCARD;
I have to admit that "IDE_PCMCIA" is a poor name. It  might  be  more
clear  from  the  "Documentation//Configure.help" file in the current
Linux kernel:

...
Type of MPC8xx IDE interface
CONFIG_IDE_8xx_PCCARD
  Select how the IDE devices are connected to the MPC8xx system:

  8xx_PCCARD uses the 8xx internal PCMCIA interface in combination
             with a PC Card (e.g. ARGOSY portable Hard Disk Adapter),
             ATA PC Card HDDs or ATA PC Flash Cards (example: TQM8xxL
             systems)

  8xx_DIRECT is used for directly connected IDE devices using the 8xx
             internal PCMCIA interface (example: IVMS8 systems)

  EXT_DIRECT is used for IDE devices directly connected to the 8xx
             bus using some glue logic, but _not_ the 8xx internal
             PCMCIA interface (example: IDIF860 systems)
...

Here we renamed the poor "IDE_PCMCIA" into CONFIG_IDE_8xx_DIRECT.


>   This is the PCMCIA stuff configuration of an config_TQM823L.h (¿is it the same i need to include on my config_FADS823.h?)

It's probably the same, depending on your address map.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I like your game but we have to change the rules."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
