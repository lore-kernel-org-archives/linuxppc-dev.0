Date: Wed, 5 Nov 2003 20:38:28 +0900
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jeff Walther <trag@io.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
In-Reply-To: <Pine.LNX.4.44.0311051135280.30771-100000@opal.biophys.uni-duesseldorf.de>
Message-Id: <93018FE5-0F84-11D8-A51F-00039394E428@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 2003.11.5, at 07:38  PM, Michael Schmitz wrote:

>
>>> In my queue of projects (massive and ever lengthening) is to install
>>> a 53CF96 in place of a MESH and/or vice versa and see what happens.
>>> However, I wonder if a similar test could be done with software.   I
>>> assume that Linux implements some kind of driver to support MESH.
>>> Is there a driver for the 53CF96 which could be substituted or
>>> compared as an experiment.
>>
>> There's a driver for the 53C96 in the Quadra (mac_esp.c and
>> NCR53C9x.c).
>>
>> The NCR53C9x.c core supports various 53C9x chips, including (53CF9x
>> and FAS*),
>> and is used on various platforms.  It's very similar to the esp.c
>> core for
>> SPARC, but Dave didn't like us to merge non-SPARC support in his
>> driver.
>
> The Quadra 53C96 driver is a strange beast since we don't know how to
> use
> DMA on those boxes (in case they have DMA) so it implements PIO.
> Plus we had trouble with reselection interrupt races there. Better
> look at the Amiga ESP code.

I once modified NCR53C9x.c to make it work with DMA for NuBus PowerMac.
  It works with both 53C94 (on PowerMac 6/7/8100) and 53CF94 (PowerMac
8100) behind AMIC DMA (see NCR53C9x.c and nbpmac_esp.c at
http://nubus-pmac.bkbits.net:8080/linuxppc_2_4_nubus/src/drivers/scsi).

--
Etsushi Kato
ekato@ees.hokudai.ac.jp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
