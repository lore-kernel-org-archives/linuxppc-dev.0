In-Reply-To: <v04003a00b43e690932c6@[216.81.26.227]>
Date: Fri, 29 Oct 1999 13:58:48 +0200
To: Tony Mantler <eek@escape.ca>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: question about altivec registers
Message-Id: <19991029135848.007534@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 28, 1999, Tony Mantler <eek@escape.ca> wrote:

>I think saving registers in a subroutine is a pain no matter how it's
>implemented. If the VRSAVE is used as a count, the subroutine still has to
>save the old value, save the overwritten registers, calculate what the
>proper new value is (think new < old = oops!) then restore the overwritten
>registers and old VRSAVE value when it exits.

In their latest Mac compiler, Metroweks added a pragma for manually
optimising this when you know you'll use a bunch of those registers:

<<
 #pragma altivec_vrsave allon is now supported. It sets VRsave assuming
  that all altivec registers are in use, best used with
  "#pragma altivec_vrsave off" so only the parent routine updates the
  vrsave register.
>>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
