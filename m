Date: Wed, 26 May 1999 15:07:55 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Simone Piccardi <Simone.Piccardi@fi.infn.it>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME2431: how to use vme?
In-Reply-To: <Pine.HPP.3.96.990525101402.6041D-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9905261456310.2110-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everyone,

we now have Gabriel's Universe driver working with a "LeCroy ADC1182"
VME board, which is simply an ADC board with 8 channels. We generate
the sample-pulses internally on the board, with the Universe driver.
In short, there is no problem using this board to measure (different)
charges (in parallel). Operation is in A24/D16 mode.

I just thought scientific-minded people might be interested in hearing
real-world applications of the Universe driver (and Linux).

In the meantime, Simone wrote : 

> > A second question is about the BLT flag, as I understand is used to
> > enable block tranfer. Now we don't need it because the board that we use
> > has only a readout address that take values stored inside internal FIFO;
> > this lead to about 700ns to read one word, but our hardware people are
> > thinking about to make a new board, putting everything inside a buffer,
> > so if I'll had to use this how I have to read? For what I undertand
> > block tranfer tranfer on read a whole block of data but how can I
> > specify the size? 
> 
> Block transfer is mostly interesting for DMA and burst writes. Actually on
> VME block transfers are signaled by a different addres modifier (AM) code
> on the bus. You don't tell the length: it is the number of data strobes
> cycles while the address strobe is active which determines the length. The
> universe will only perform block transfers exceptionally on reads: when
> you perform a read which is wider than the programmed VME bus width
> (reading 32 bit on VME_A32_BLT(16) for example). It will perform block
> transfers on writes, especially if you enable write posting which will use
> the internal FIFOs and your processor performs store gathering (PPC750 for
> example). 

 We too would like to use block transfers. It does not work however.
 ``Device not configured'' it seems. I just changed (in the VME_window
 struct) VME_AM_A24(16) to VME_AM_A24_BLT(16).
 Unfortunately, I'm no VME expert. So, are BLTs something a VME board
 itself must support ? Or do I need to set another parameter ?

 Any input is highly appreciated,
 
+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Fortunately, Hill Giants have large blind  spots in
 which a human can easily hide. Unfortunately, these
 blind spots are beneath the bottoms of their feet."
 - 'Hill Giant' (M:TG)
+-----------------------------------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
