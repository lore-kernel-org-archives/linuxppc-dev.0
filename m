Message-ID: <BE1C564723B3D21191FD0000F840E39801D815ED@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial Port Baud Rate
Date: Mon, 7 Aug 2000 16:37:31 -0400 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C000AF.4FA2C7DE"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C000AF.4FA2C7DE
Content-Type: text/plain;
	charset="iso-8859-1"

I recently had a problem with a serial port, using the HardHat kernel 2.2.13
which is probably getting old by now.  I was using the serial port for PPP,
and I saw more framing errors at 115200 Baud than I expected.

The system clock is 50MHz, and when I calculated what commproc.c set the
baud rate generator to, it came out as 111607 Baud, due to truncation of the
remainder after division.  If rounding were used instead, the baud rate
would be 115740 instead.  I therefore changed commproc.c, as reflected in
the attached patch.  The modified version runs very well at 115200 Baud,
with no framing errors.  I also included a few lines which should in theory
allow very low baud rates, although I have had no reason to test this.
--
Dave Brown, Principal Software Engineer
Harris Corporation, RFCD


------_=_NextPart_000_01C000AF.4FA2C7DE
Content-Type: application/octet-stream;
	name="commproc.c.patch.gz"
Content-Disposition: attachment;
	filename="commproc.c.patch.gz"
Content-Transfer-Encoding: base64

H4sICBwdjzkCA2NvbW1wcm9jLmMucGF0Y2gAhVJrj5NAFP0Mv+J80lJK6VCta1+pVmt8VM1u16+E
DrNlImUIAy3Gx2/3DrSra5pICDOXc+69554Zz/OQyqyq/ajgiZ/n3L+q61Aqn6v9Pi8U7/Nf1lpl
eFdlwFMwNh6MxuwKwWAwsF3X/W+6tUkqyk4RPAMbjofBmD1vsxcLeMGQ9VgA16zBEywWNvamBM/3
oRbltth1KpmVoE0Pza6ISuHY+G7DOqg0KmUqGsDqbvOJ7VoNKZYHGYtiYoNofhebRGrQu1MqhshU
tUtQKuxEiZv1UqOoskxmu755KKPr02ebY4a2e9d5RIJyb87zkJRwNmlxd2aETWzPNDfszsvrN+Ht
i+tNuPzwHn4rFtMpmIMfWH5eh4bw+iMJJakk7FZXUZp+w1GAR9njspFUJgKijjiNHVVxU6RPdHTx
6a4By6MCT5UWusQhSiuhe+CJoh8NrDKBoywTE7R5qYiIKopCFaYSzedaJ49I9gXRxkl5RwOZAB4e
DOZ3TrkucxwH83/mvocJ81oLHCp3buh55+JnBdMZBvVqtWpYJyfvsUveWSLV4gJ5PsfwIfmv4NXb
L2xEB/fTXAqy/oacjpBIugo6FyL+Y7bxln/to702sRLanEykdbVvDa7ZyP4Nya/TvjsDAAA=

------_=_NextPart_000_01C000AF.4FA2C7DE--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
