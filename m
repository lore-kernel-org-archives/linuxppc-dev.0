Message-ID: <39437131.F1DD3AE6@wanadoo.fr>
Date: Sun, 11 Jun 2000 13:00:01 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Geoff Hutchison <ghutchis@wso.williams.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Possible gcc bug?
References: <v04220801b568cc2210b4@[129.105.9.193]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geoff Hutchison wrote:

> If I'm being a complete moron and doing something silly, please let
> me know and I'll eat my words.

I think you do: You are passing over the array bounds. If I remember my
C basics (which I never really learned either) correctly,

double field[loopX][loopY];

allows indices running from 0 to loopX-1 and from 0 to loopY-1.

In your first loop

  /* Initialize arrays */
  for (x = 0; x <= loopX; x++)
    for (y = 0; y <= loopY; y++)
      {
      	field[x][y] = 0.0;
	points[maxX * x + y].ptX = x;
	points[maxX * x + y].ptY = y;
      }

you are clobbering random memory locations that may be different for
different compiler optimisation levels.

Replace "<=" by "<", and your errors will go away.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
